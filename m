Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 565212DC5B3
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Dec 2020 18:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgLPRuN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 16 Dec 2020 12:50:13 -0500
Received: from sonic312-30.consmr.mail.ne1.yahoo.com ([66.163.191.211]:34284
        "EHLO sonic312-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728193AbgLPRuM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 16 Dec 2020 12:50:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1608140966; bh=3EBHTGDJF1gcSCv9yVgxfuZ3fyy08xIs5v/deB2iQrg=; h=To:Cc:From:Subject:Date:References:From:Subject; b=LSV/V5N8kLngb2e31pTWH4lUXChNT/eaj7cObjyh7bvc9vFdubr9BV3c3RmXZwEl6QSLnquRUSlMSGxobzx0BCrA2m5i+oGgGGYQj3Afa7BHh7Lt6gMRHjommrnLUWyf/sWURB6X28BJKNgp5IxsrM9veiotLYHb1bc11E+YGSd8Ip0WWtJ9wQmNkP0VtoJThoSF64XOcRMa6VciquKyDcMFJa9WfvoCpAlaP1i1OtW8oeystRAxwlGln8Q9Tt5EjP519+wmt8HY70TCJRFLMSETuYQYKMlmuXiBv8JOcLzM//wVBRMIhGKJ6Guuludwzcgn+JjcL958aMLQ260ovQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1608140966; bh=sWRoum6wv925R+1Y6QENBcllvt8V4XS6K3UqUGkeaiH=; h=To:From:Subject:Date:From:Subject; b=rrpVOzP7AUoZsDcYCZ2pbtFpepp8uYHRBRIFEcwB6Bwlm4roqJ4CpPU9GHrf6jbd1h5SW0ssDcleUY88OO6dH99jC5LZ50hkfarV4AML3AF5nNdlmuCOKRrDyzgbZecdlc1aMLSR+fxjpiLrOVBEHR1Sr0Yt9MVmcZ0sgPZUcgPtBuAGOZLcfBIw2jrvXptn5SX/8GkFBWROQK2HhSgjTG7h94RB3zUrWqqjV0BB/u9f47sjUNujXVURtCIJWaKvsduvRohGZZ6T3wBWeFSo7yyWXslxIxUGVOOZ9oxRNgIPbL1awLu9BjisvArfHg5r3bhRP3qQ9Or1+BhIClK7PA==
X-YMail-OSG: xkGwK3UVM1mfnTJ8DrlGItrLys_CUKBDQbvXrORKAoXmuJ7JbUeX8amGBh907tW
 vuxVmwrQo8_Q1fJerxjKmiStN12wve1KHM0DbiT5xkLy_PaNbg1qWaJ81OIlFttcj3b1VBqGgMa2
 qRjEBe_oGxKX3sWJHFM88nHorZU9yInmlVoHML9.OPDp6tfy2NUOq4Gw5FHP3pwU7KTcE0.ta_ez
 vF6TaD.58DKPi5sXnSZku4vpCaSp3WrdCkBLGw09CI3awyEWAG1dWIoNAJ7URINk7bUp0K1tsZpe
 7REo16b5k7qSnYU5DSovF_lvltPYBbXaFYG32oDayWavjJTFBr6FekH5Tp.XANvRcfC4V8J7WDt9
 LIzKHqo3Gz9dfBV4gfa9MiROTOvjPr1PAcIVmCLKzb_rppOfk7fFuNnI0n6ah0.._c1r6myTw5G.
 3.MPv_oD1nGAfBhaB0YJ2mssqG4gZUY2mjCplzHYT5UpfZUeJ1UufgKs6WKqOMts5CRBNdCVchhM
 60Jl_GKyBPXk5RWl9btZbLl_L6aDm278UR49M.4PGENfRhPmzyX0h_cpEs0DQluSYmDmSFV2GrIM
 Xrp3Oh16AWqY9zE5QVZDeDtVLtbwPGl1OyGdVAlmRHP3m.RVdE0JwnEkYUwCc73nI8cD_dgyKsoW
 Yc9KyqlnjQsuPWUJ5LOhgnu4FF7ZmxDqda7ElJv3JRz_xtfcSycHNO8vjx5_lOKYSy8Abn1DUc5z
 ZrhZ7WV27jkgaCTH.lQ7Fyon.Cyr9pkHZAQbs0y_Ifk6BOZInROuhcmRjIO7luSlg5ARanA9gIcR
 cNBt4B5zFVRwErtx6DdqUsdpvZ9rj1e8FWc0fxrPNwNc9Q_jfAAhAYWMsktgAZ2hxQM9_MK90cO2
 3yhrZ9ca0rZZs4jRTjPg8YeOMBfiu_moA8qKALFLDcxtcrhKNqtqiYMJAOAWaktHTYYAeC9azFIz
 Gc2cTRyjFGqy.KduHlPJyD1QhXBUVTfN4k.0ILsoqVhaQq8GSv1MiGTn6.nXNT2IG1_yalxGrIY3
 c0.JL_w8WzPlbjDkrsnNMGlkmqjbxJ1bXI3RZ6EbRwK_jbEgLzbzl5A3rrqLbNiABHznT2sUUFHx
 cuTOvghurMS0YKo8iSkLVOax_5_v.oUk7lPN12umt5OKi.QinOZSeNL68vCy7znvpNGTH5tAkncd
 BSNSrzi4yf85hxgQslJAkUqnJoLW2uZyATgYh2.TgJhfGPRDcBV1PFh9cDyGI4WiNLtbNLBx8sev
 gWQNQ8S2g77D6DsvIM.KwEAKnqfs6DlYOmalyLoDKaUCyad3R3heiDpXQ_4JKipkZdga_UV8tKXq
 MsLRvYfNPipacnNWr3CufAcDj_qyFZTvVpZT_IFh2vFtu83PUQHrQ759pzZO4Es5hmMts0Aq1bPr
 47r1ieBhdinmOsSdPImr_6aJsIPyn5Bp1BhnQUX50HsRLF45RwhB2_7JEx8A9cOSdFJng8h7IYKi
 lLv2G8kVEW.894FGjVE4s.DO6uSip6C07Nn64hXHOwyXVGJeGRWksF4z2IJ3__9lHJFtlxH.G_kH
 3CPcLRGrGCpJq9YCnOD5C_b9t4PsLSv.9X4bZL9f7zuQr.PZh.ZTpoonQb_aDUGhpL37o1WLqrUp
 L00cuIf45DSz5ohCulmdDfGuqj.6QtsTf8MGhYVF1A.q1hMKBTjIrPBr1DTvrXNJpHarWbEeTJpz
 LiP85MdMuPV275Jfj7iAtkqHs2KpDmMzHDBuMNnrttmawxo0BFTutNaC.3Z6YGTEu6ddQkzk.b1n
 UbL.gzcNUaln.OcmYpxp5dfkLpwIpk7Dc8a6SPw8h8XosXsndH7s3_b8HV87ojmS4AlRcxUTVW9Y
 .majGfj92G.3RuwpwGvoXJ9HPt7iyiRehaZUIWJPSc0oz1SSsdPwdsmil4RzaxmXfJSyHmicr2dL
 uXUfpvShHHxt_p.lfBO2hk7Qqfvq3vuwkQdg86vnXgz972Ga_Z08QL9czRwMyLF8MCko8.N5OBQe
 qhYM0aDD0DERvrxBcUIM.vGHuYdIIZbN6DVSNQwifpJEhCSzC2hPNfvapIOGODzHxMx2bVia6D.D
 9XlLzqzlHPR7sOIzbJb3IayZ3JYUll_SaLuLY3mCM_xMQp6VWUZCzT6IuPyIuMuB_E6Kiz5fdVf4
 oc.7fuJOPKlG0mP5Ywsfc3h5Y2NQe2CIAIDbCl_ah36XRBHnRL3kcBZbIh_EVVsPLfl5eSP_2Mto
 SM1Oh71phBG_DD7yNdM_sTGzriS4GUEBgsLLnrSd4akMYsj3lV0SMh862kXewhX3PyUms_pXe4f3
 F34O.x3OqcOw5zg1f7a4fYTX5JBxH7_97n3NuT_M0OoEukWl62Sqaj6pmPGcMT0gG.PHFrOhF_vz
 r03hgZJ.o3oAhCoYbfsB2UlpIIuObVQA3.FrW.KHirjgV0vaxgMMQDJoimoEdyTtSEqGzAQzrRC4
 oV4csm3KF5urQbznG1qT5hTpskYV00LA.hXU84iCQZqzQwPxGqN77xSu.POwPN0txtt5oXndlZbB
 IG1wtf0Cefcc88TWMBYYyri_lPz1hvy2HS4FQwf2JWwbW5F4WdA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Wed, 16 Dec 2020 17:49:26 +0000
Received: by smtp405.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID e4a961bf236198106970ca083dc1b942;
          Wed, 16 Dec 2020 17:49:25 +0000 (UTC)
To:     Mimi Zohar <zohar@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: Security module stacking patches review
Message-ID: <99c17a46-91ec-b934-333a-adb8c44e49da@schaufler-ca.com>
Date:   Wed, 16 Dec 2020 09:49:24 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
References: <99c17a46-91ec-b934-333a-adb8c44e49da.ref@schaufler-ca.com>
X-Mailer: WebService/1.1.17278 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.8)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

I am going to be putting out another revision of the LSM stacking
patch set just after 5.11-rc1. There are changes in the integrity
sub-system that need your ACK before I can get the code upstream.
Can I please get your review this time around?

Thank you.

