Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4011A1C2A6B
	for <lists+linux-integrity@lfdr.de>; Sun,  3 May 2020 08:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgECGw2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 3 May 2020 02:52:28 -0400
Received: from sonic308-19.consmr.mail.ir2.yahoo.com ([77.238.178.147]:36313
        "EHLO sonic308-19.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727086AbgECGw2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 3 May 2020 02:52:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1588488747; bh=HCBdmXO5/l665w/MwYeTKYgprR4CxrsZjPuQNxf8ZBg=; h=Date:From:Reply-To:Subject:References:From:Subject; b=Vv2+uM6nj7NBa97+9iZ6RXO1cBFs3xJP+HRgPl7HgBjtac8RCvfVQ08EkPf9wvtd6a7EGGj+65Am/zblOQf2tenQRtvyQrTaIkxXi0EaPIuJpe67rZ3l/Rac9nowsccpN05nO4XwQN1Bl83IiVkZk+PCXz4hbCrHPwUB6SNu4jITnKKUTZdEoCMXqdjT4jWOrO6TpESSIhocxcAqZV9WUJwckZ7TyfJpbzXfKEyxRwuYv169weQ6N8jT98xSqTqVPhxkXoCz3tisDKt2N+pi35Ju6EaQ4WourUcWXTOyEgg9GxvXOyEOmjFjs70KkR4wBaRIEKMcEDlXV8WNGuidjA==
X-YMail-OSG: oiMm6S0VM1lm7JxgEsjb6A.UbPyn83nGg7OaotgBSllRQUIyNXVcxaO7lANcZMU
 aHnkUmO3iHTwTH2Mh2L3sU4DIvkvWYYQkxuxnWwUUS1JVXyVchvVojh1INFmb.R7DeZGRDiS9I2c
 XXKAv588Awk2rTYAX7bSoqQsoh7Nys2yX891FS5Zd4GaTmY2brNX_G6qPothhB5UNnDvLBGNw_QE
 7mdSKynpbGjLpJOeXiSeJjprLNCFxzn9v1CaliBs9O0Pv_79LB875TTdcQU6SUO7_wkx8jqix7Rj
 5azy63OZ0mFXBIORIYyYUh8wcgVYoLMC7NFChvuGd54aHClywbKsU2r_5CkyO66ck5MI21NOHvIG
 i614CwvPjlRhbymGtF968AJ3n9l2FanPXnfoU8NseEIT.6Rq6a1xo3e3e7bXIe6s0p.XPE_ttZch
 wJPufl5gS36qYWe0Uc5KP1YHtE.ZiiGIr2pJl.XMnBwR_EXsYbfXCtQpVgzwy1YYk6PLIKU9Kmo1
 29ebFRjkmXNNEEIYH0ZWnjLp9ceL6Cwyu0j7EAc6uF2DfWm16A5ScpXBtUi7elYdGQt6kW5kMUHx
 XuuqCnSuslenjvgqmLhiRxwrY5Ia34HiYzAziX_CRPe6uI6BYfqPdRIjvta7Zl69U7Y1iiTpdiZO
 ha4VKfbUaCqBpR.WgbLLybVcTNWeMZmbJCz_6sm5fl.Q6FzNNLJsq7sX1rv4wNzXCTPrdA8NlWmu
 vJYLG28PIY6.bHeWmSc3WB6nH75QDi629guHNtjDQBLfvEXdpuXzXHwezEnWEEUP7hejcFZ.Bokp
 bxRMWISZhb29Ijt3CqTLd5LAhKoyBsB0.il4dznwP6xpomhTxbS9LYNSYCCDONk_gNlmkSAgwLgn
 KgU1rd29XERkdeBTv3CxzAbtoNJCQZGksbuNqtMh7WOINDDvcNT87CWTTPtw7sjXLSkg_X7VhHQF
 pHgXNaJ6qq5ztcoZ0rRbHh7M3nU_qf4v8QZmnVVrYgAu12uFUbT5gztDZ0hde2W.7e9nLr1CDekM
 oxJiXBIOmqBy_Dn6qm1N9p0eMg6gBGTWW1OqTqRme3uM87ddfPximYkTty6AK_Fo0tcptM6dqQ4D
 ul7nHg2UlwhF8XhoaQnWljb9f8R5Kjs_XvIoguNyhLtDC9dhtjOdX2niFKDstUZSEGtBK.4J.I51
 FjPl_Ht7VmocFuXXt8KgN1fXkseNMoLN4Um2qnYmrR9FO5n8firFT1zY3_MQ.uuY0CyL_2gAdNT6
 dOjVTCauGElamXzGprJneoYzJOMOoPCUZ.ItPCDBpMUboLac_VEnYzinMKXX1_UvF2EoII_pRqw-
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ir2.yahoo.com with HTTP; Sun, 3 May 2020 06:52:27 +0000
Date:   Sun, 3 May 2020 06:52:26 +0000 (UTC)
From:   Miss Pamela Render <pamelarender45@gmail.com>
Reply-To: pamelarender45@gmail.com
Message-ID: <1137921726.642686.1588488746422@mail.yahoo.com>
Subject: Greetings From Miss Pamela Render Please I Need Your Urgent Reply!
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1137921726.642686.1588488746422.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15756 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:75.0) Gecko/20100101 Firefox/75.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



Greetings From Miss Pamela Render Please I Need Your Urgent Reply!

I'm Pamela Render, from USA. I am a highly motivated and willing to learn, I'm also hard working lady, very relaible. I really want to establish mutual friendship with you, I will introduce myself better as soon as i receive your email response.

Kind regards
Miss Pamela Render
