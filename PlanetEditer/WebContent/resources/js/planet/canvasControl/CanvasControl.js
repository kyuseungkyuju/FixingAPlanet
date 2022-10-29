export default class CanvasControl {
    constructor() {
        this.render = null
        this.init()
    }

    init() {
        this.seaLevel = 0
        const option = {
            powerPreference : 'high-performance',
            antialias : true,
            // 'willReadFrequently' : false
        }
        console.log(option)

        this.mapCanvas = this.createCanvas()
        this.mapCtx = this.mapCanvas.getContext('2d', option)
        this.mapCtx.fillStyle = "rgb(255,255,255)"
        this.mapCtx.fillRect(0, 0, 1000, 500)

        this.bumpMapCanvas = this.createCanvas()
        this.bumpMapCtx = this.bumpMapCanvas.getContext('2d', option)
        this.bumpMapCtx.fillStyle = "rgb(127,127,127)"
        this.bumpMapCtx.fillRect(0, 0, 1000, 500)

        this.colorMapCanvas = this.createCanvas()
        this.colorMapCtx = this.colorMapCanvas.getContext('2d', option)
        this.colorMapCtx.fillStyle = "rgb(255,255,255)"
        this.colorMapCtx.fillRect(0, 0, 1000, 500)

        this.continentBumpMapCanvas = this.createCanvas()
        this.continentBumpMapCtx = this.continentBumpMapCanvas.getContext('2d', option)
        this.continentBumpMapCtx.fillStyle = "rgb(127,127,127)"
        this.continentBumpMapCtx.fillRect(0, 0, 1000, 500)

        this.cloudMapCanvas = this.createCanvas()
        this.cloudMapCtx = this.cloudMapCanvas.getContext('2d', option)
        this.cloudMapCtx.fillStyle = "rgb(0,0,0)"
        this.cloudMapCtx.fillRect(0, 0, 1000, 500)

        this.randomDotCanvas = document.createElement('canvas')
        this.randomDotCanvas.width = 200
        this.randomDotCanvas.height = 50
        this.randomDotCtx = this.randomDotCanvas.getContext('2d', option)

        console.log(this.cloudMapCtx.antialias)
    }

    /**
     * 랜덤하게 점이 찍혀있는 캔버스를 반환해줌
     * @param {String} color 
     * @param {Number} density 
     * @param {Number} angle
     * @returns 
     */
    getRandomDotCanvas(color, density) {
        this.randomDotCtx.clearRect(0,0,200,50)
        this.randomDotCtx.beginPath()
        this.randomDotCtx.fillStyle = color

        let randX = 0
        let randY = 0
        for(let i = 0; i < density; i++){
            randX = Math.random() * this.randomDotCanvas.width
            randY = Math.random() * this.randomDotCanvas.height
            this.randomDotCtx.rect(randX, randY, 2, 2)
        }

        this.randomDotCtx.fill();
        this.randomDotCtx.closePath();

        return this.randomDotCanvas
    }

    createCanvas() {
        const canvas = document.createElement('canvas')
        canvas.width = 1000
        canvas.height = 500
        canvas.getContext('2d').lineCap = 'round';

        return canvas
    }
    
    updateCanvas(ignoreTime = false) { 
        if(new Date() - this.lastUpdate < 40 && !ignoreTime) {
            return
        }
        this.bumpMapCtx.drawImage(this.continentBumpMapCanvas,0,0)
        this.mapCtx.drawImage(this.colorMapCanvas,0,0)

        this.pixelList = this.bumpMapCtx.getImageData(0,0,1000,500).data

        this.setSea(this.getPointList())
        
        this.lastUpdate = new Date()

        this.render.setMapNeedUpdateTrue()
        this.render.setBumpMapNeedUpdateTrue()
    }

    updateCloudCanvas() {
        this.render.setCloudMapNeedUpdateTrue()
    }

    getPointList() {
        const pointList = []
        let node = []
        let isPrevNodeTrue = false
        // 모든 픽셀 검사
        for(let y = 0; y < 500; y+=1){
            for(let x = 0; x < 1000; x+=1){
                if(this.getPixel(x,y) < this.seaLevel){
                    // 저번 픽셀과 이어진다면
                    if(isPrevNodeTrue) {
                        // 색칠 길이 즐가
                        node[2]++
                    } else { // 아니라면
                        // 노드 생성, 추가
                        node = [x,y,1]
                        pointList.push(node)
                    }
                    isPrevNodeTrue = true
                } else {
                    isPrevNodeTrue = false
                }
            }
            // 초기화
            isPrevNodeTrue = false
        }
        return pointList
    }
    
    rangeCheck(x,y) {
        if(x >= 0 && x < 1000 && y >= 0 && y < 500){
            return true
        }

        return false
    }

    getPixel(x,y) {
        return this.pixelList[((y*1000) + x)*4]
    }

    setSea(pointList) {
        this.bumpMapCtx.fillStyle = 'rgb(' + this.seaLevel + ',' + this.seaLevel + ',' + this.seaLevel + ')'
        this.bumpMapCtx.beginPath();
        this.mapCtx.fillStyle = 'rgb(0,0,255)'
        this.mapCtx.beginPath();

        for(let i = 0; i < pointList.length; i++){
            const [x,y,length] = pointList[i]
            this.bumpMapCtx.rect(x, y, length, 1);
            this.mapCtx.rect(x, y, length, 1);
        }

        this.bumpMapCtx.fill();
        this.bumpMapCtx.closePath();
        this.mapCtx.fill();
        this.mapCtx.closePath();
    }
}