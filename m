Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 550D8245DD4
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Aug 2020 09:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgHQHUg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Aug 2020 03:20:36 -0400
Received: from sonic316-55.consmr.mail.ne1.yahoo.com ([66.163.187.181]:36708
        "EHLO sonic316-55.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726089AbgHQHUg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Aug 2020 03:20:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1597648835; bh=wQR2TNpnSC5+pl+9xCwBDdU8shZ+1jYIhLI8TGcKGS0=; h=Date:From:Reply-To:Subject:References:From:Subject; b=rj/Ao4sSjyOH0l9IiWgqJn+hlur38woztj3WnZU+bYPaWFK087gNg25sCy0yH1SPnn8hQ8KXjBULFKtfh5BclmAxxbzelhRhDm/3ZbM6hekGyaYc4C5ISiQg+K+7mUpDmrlxu8+thKhFzuzqMlCDTtgPvlyAMvoEL6FMVMwPPjPvHSzyOP854ep5fJS/MoM+SIxT0vjL28YB3T3qNr6p2hDhXMrX4+Dg3OT+NyUZxIvI3dyXiBEzakAk4DkZcFjHQnqgJBU1ZVGjGfiSU5vJx5PAYygxkOnm0NjBjrxQnZiQS1Spd0NFMAmZfFrTqCnwJZUutACAAxJmkMDn69wktA==
X-YMail-OSG: xG5Dy8UVM1lXH5YD2PpeZel9PqZYKWHci4QL49Na4g9s_cv3TmGs0SdmABXapPA
 .4.FFUWcGzQ4wA4uQBA0Le.4If3Hz_krhZo1BqtABk6_98E0mKeuHHcR9kfaUfWkL0R6a0jFa6px
 KUXlmptsbIlqRAiN3BUnspi_UbLS.mVs9g.HiC8B1j1lIq.U2mO9yuIBq0iiu1MoxLCcT0fSpVnD
 3Gsr_IzNymuvWJTqlTdA2EumV.9_s21BAYh0SlaL5a_iRBg3H6YJAO7WE1Fqjv8WjCALCBq8iyZ_
 OGHvv81.GYgBearLG3PlkiRrhwd47w0CoQTwXzTtiDc_.A5JR9_NLx8zvu6wuUydChKdB_uusoeh
 95YXi7bQXazVggiHbeBfG1Z10XOwclSKtm3dh6r79mCX45Bk1xdJzsqiRO9ANTxix_r0zP4jqrDD
 2MnRvoR6zknfdGfZakYhmKGKWK7atgf9Ax64MobFOg3owElxrJU3szmSFD2xi2X1PymR0XYOJDND
 ask.GMhMh7.kjCCIY3LgCW93deLBCrPnsLzGdPaLgytkAad0J1nWjjizdpzfFJ.qWFd9HA.UHsHM
 UI17dci2LpvMlTs3PErAZaz799ckvzNJDHwgiWwiSzhVjJK3VcvbxMtW9X_QEd9Kgl2O3.woXnm.
 zb1NyjGcSpLuR_82VSwWuCVCWQOT6Tu5C.xq2uWcPnt3ncJHB.SwT2x3IPFBf82lmt36p.Yajgqr
 ejbOQekDevuwAjj9N7iQuuwlW8AZpfd3l3IhrZ7vywdUQefGWMcA4DDUTb7mBK0VPgLhFsXc1.Fz
 zji9mhwmX71rfvSzq2s10J1gty1O4xXeavjeMssvfIcySlOmXcTLb466wRa2VjZteV_ausMdnJ3v
 BTjpKUeSZaH06qs7kc_rYcdAj.W06LoiCdsyrNY0T_fRa71TrZ1wXWsy2Hm0Y4ExRRgbsHayq584
 rNx2NWLQMjYt3.Rnh1ZE6C1e09snD7E2vweBN15JB6ypUkKyfPjXl6uo.gAGhAZiMCIBy7Kf413E
 lULJ5Wd5M9hiKXWFSmRtBJWRQUg2JBZwTeBoZqozYMiE65e3GQWpRAwIyQfLihXnkjGZVlwS.lYT
 kkGihBKE3cewVJk9wea.N7KhDyfpart0W7u7QGjnV.MMi39CMt53D9sF4p7mhUHo56vPZfezgjw5
 6l2M7pqnCksq8vc30rNeTEoFH2fgDW.9pIbtHnRKeVHm9Op9xEIxixpshes.UvSE..4248eUSzy7
 JougUGC2St0msgGwM_.ssOzSGjNzPx1kAX_ZnZEVUF5Yn9IOL9FG3_TLs4nqo9wwx2WtEQky8.D6
 2IF4zu_pheYw6JkKs02bvScupE3s24DRr9KsqTD1OeLyMKCyGXJWQIXwp_aVmo1BEFsL5OsL9O7E
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Mon, 17 Aug 2020 07:20:35 +0000
Date:   Mon, 17 Aug 2020 07:18:35 +0000 (UTC)
From:   "Mrs. Maureen Hinckley" <mua39@gvsao.in>
Reply-To: maurhinck2@gmail.com
Message-ID: <240010608.3000878.1597648715121@mail.yahoo.com>
Subject: RE
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <240010608.3000878.1597648715121.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16455 YMailNodin Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.105 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



I am Maureen Hinckley and my foundation is donating (Five hundred and fifty=
 thousand USD) to you. Contact us via my email at (maurhinck2@gmail.com) fo=
r further details.

Best Regards,
Mrs. Maureen Hinckley,
Copyright =C2=A92020 The Maureen Hinckley Foundation All Rights Reserved.
