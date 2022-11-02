import PlanetController from '../ajax/PlanetController.js';

export default class CreatePage {
    constructor(app) {
        console.log('CreatePage start')
        this.app = app
        this.container = document.querySelector('.planet-create-container')
        this.controller = new PlanetController()

        this.init()
    }

    init() {
        this.contentField = this.container.querySelector('#planet-create-content')
        this.titleField = this.container.querySelector('#planet-create-title')
        this.createBtn = this.container.querySelector('.create-btn')

        this.addEvent()
    }

    addEvent() {
        this.contentField.addEventListener('input', this.contentFormatCheck)
        this.titleField.addEventListener('input', this.titleFormatCheck)

        this.createBtn.addEventListener('click', this.onCreateBtnClick)
    }

    getTitle = () => this.titleField.value
    setTitle(value) {
        this.titleField.value = value
    }
    getContent = () => this.contentField.value
    setContent(value) {
        this.contentField.value = value
    }

    /**
     * 생성 버튼 클릭
     * @param {Event} e
     */
    onCreateBtnClick = () => {
        if(!this.contentFormatCheck() || !this.titleFormatCheck()) {
            return false
        }


    }

    /**
     * 150자 이하, 한글 또는 영어 또는 숫자인지 검사
     */
    contentFormatCheck = (e) => {
        let content = this.getContent()
        const reg = /^[0-9a-zA-Zㄱ-ㅎ가-힣ㅏ-ㅣ]*$/
        if(!reg.test(content) || content.length > 150) {
            content = content.substr(0, 150)
            content = content.replace(/[^0-9a-zA-Zㄱ-ㅎ가-힣ㅏ-ㅣ]/g, '')
            alert('150자 이하 한글 또는 영어 또는 숫자만 입력 가능합니다.')

            this.setContent(content)

            return false
        }
        
        return true;
    }

    /**
     * 15자 이하, 한글 또는 영어 또는 숫자인지 검사
     */
    titleFormatCheck = (e) => {
        let title = this.getTitle()
        const reg = /^[0-9a-zA-Zㄱ-ㅎ가-힣ㅏ-ㅣ]*$/
        if(!reg.test(title) || title.length > 15) {
            title = title.substr(0, 15)
            title = title.replace(/[^0-9a-zA-Zㄱ-ㅎ가-힣ㅏ-ㅣ]/g, '')
            alert('15자 이하 한글 또는 영어 또는 숫자만 입력 가능합니다.')

            this.setTitle(title)

            return false
        }
        
        return true;
    }
}