Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBABE188359
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Mar 2020 13:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgCQMLr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 17 Mar 2020 08:11:47 -0400
Received: from sonic307-2.consmr.mail.ne1.yahoo.com ([66.163.190.121]:34795
        "EHLO sonic307-2.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726713AbgCQMLq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Mar 2020 08:11:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1584447105; bh=kcevCRoll2+Bsa3FDERpIV72LVcB1A4YV1b5N2AWYBk=; h=Date:From:Reply-To:Subject:References:From:Subject; b=Mm+amEABuqOJSxEgMJ/+nsPA/ert+WBMiBEAweTDEsx0N036ol3lmnkGKYWfx1C2elo7X2MRdIotA+1oIY3R33KgQYVWZPOomU9AK+h0oYREGlTeqU6XgPE8Hm4IMzgjKLifqesthHoal8PP8ZNv5J/Rs4JtryuX+7H6/zqwwNqpCB8gMjj1IOA11oJY10PxvQ8kq2gzmJYi8JFmaIovHksWCkDP2+khyElBjOAwmHHqoEgc3O6qHrU8EA5jJvBTCWL180Y1bbtqpD4D3F6cMF0bErwQBIDmrVVWDIWiJYdSEfKS2QbzeAXQJJg3unqJTzWmN7nkDdLYNJLh27eZ9g==
X-YMail-OSG: meabeLkVM1kj4Qo1UjIKZPmYD57gR7gOgoKWAJhAgndzEP8FpYomA0vodT2zgoo
 7sGgK.kVySqbLaFz.W_wkblfN0jMp5w9BAW3QXr902Dv_G_zrhaCZzbV5wPqfES1rrrtb6SPZI2E
 pznk8b9RjhucMPpNVS8_iBj4VWaQIr2RxGjq9ZKK4xgUkbNwEwq6EtwDvQHBuiYmue13bfoywmx2
 ClCujEeJt7CoC_GmYMMhTuOo.QP8U6.RI222je7MxVK7SrULUS6l_osTHUuteMP78NY7l.PDTFqI
 glY09FeQ0qMvYADM6VZ3OClo8hcWXRW3GaWATtORTGYFet9mMRuAwZWM5u_26HoYyw1zYKFGoPIC
 XB5nswWjghnuoqXAeGtZEsjRUJG9LhgJyQDkc6cL00qYKir_uCXfE1Yf7R1cImjyWjTnPgQeTSVw
 hOECgCxqGfQYp5I2rVed9WhPiBiRwnoZFuW3cafYUeDVyV4didE8dS2uk8cXhBKMqLOnTpkdGG6O
 a2oeCSGv49CgeOKgZLD3f7bm.eabxtUAqIOV__b9udeCc0lIGeXVuaWknhwAPPHX.aOJJS7Wo0mT
 Cb_15kkvpBs00Oq6cyHwGkrUG71QGXQ.kzSe708iYcSGZ4IFFBQZq3U78tQBVT6zmKdemUY7Qsx9
 mg6El.vRbjJzEP74i_gaHx.6dKnENZZvFNvnNuIcb8zklHvgwZS01Df.tDJBa01xGoq_DEwEm_O3
 N48x7AVSyU1OVZEI2EvOyGtTY6NeRsSPSKMSO5RcC_22Sj0aClWQOt.0IMou5DfrakujXXz3I4ov
 h4LGzvx5Sm45iKCZS79a84ZEerqaaENotu.40RYrtsD8TmX2QsMijpduFznz3YG_I08.c1tT4Rel
 9BbD_vtcKKmNYLyyDqT6z.yEN0Icq51wncO4XK.oa9Uw8AzfLGRRigifle87lSIMPipCGDhig3IQ
 Vh.oMt8wiWk0gz0XNhVvu3GUxmyHRYPNHd6KpvsHfcXHPIfg4FgodNhyKAn1VC33D5DHi3fQI0I3
 NFDezcnyxTcoaUPJFtPpGiD8TUuWg_hI2QjLiIy8SgfpB4WLyhya2F3EBGQFwyc9Guxnw4..ROt7
 Wtq27ankkDbapMf80Xq0xAN762_4GTU2kJD6CNytnpBfJmiTPXjn.ZWmg3kbg5_Xm5D3Tv05X4uy
 M_OA4zS72HdEIFhqlBXy0zJaQye7Sje767SEvPxEr7kvrF7SD0GZzLXAGOxQO8xrD21jWAdDZiX4
 R3kAEKZk7kjrfXPZ1akGXosn4j4uYPL4Ou1rjpKlhq76S8vU4JOiZ_tK872l7DM84Qy965IpeihH
 P8YIG.GJzM0xKyipjV76O7oiBQWA-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Tue, 17 Mar 2020 12:11:45 +0000
Date:   Tue, 17 Mar 2020 12:09:44 +0000 (UTC)
From:   Stephen Li <stenn6@gabg.net>
Reply-To: stephli947701@gmail.com
Message-ID: <2047002212.1846736.1584446984727@mail.yahoo.com>
Subject: REF
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <2047002212.1846736.1584446984727.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15342 YMailNodin Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



Greetings,
I was searching through a local business directory when I found your
profile. I am Soliciting On-Behalf of my private client who is
interested in having a serious business investment in your country. If
you have a valid business, investment or project he can invest
back to me for more details. Your swift response is highly needed.
Sincerely
Stephen Li
Please response back to me with is my private email below for more details
stephli947701@gmail.com
