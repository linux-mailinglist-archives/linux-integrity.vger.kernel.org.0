Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7BD314224
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Feb 2021 22:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235020AbhBHVod (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 8 Feb 2021 16:44:33 -0500
Received: from sonic307-15.consmr.mail.ne1.yahoo.com ([66.163.190.38]:39203
        "EHLO sonic307-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236671AbhBHVoS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 Feb 2021 16:44:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1612820612; bh=TdUyvsmMcYpKt/pydEnCyjvPyJgpg13YLDAhqojluG8=; h=To:Cc:From:Subject:Date:References:From:Subject:Reply-To; b=i52H/djrj4bXk6q+yTUFts4nJZZsmdlr9eMsKd62NsOY3BBPFMN6Cnq6Xvy0JA/4uesJiZvNVVO7lx3R++AEFgkd1Bh+x06rMyw9+9IxgAOJPU8yEU0iXl0ZwYGhtUPElg2wQA36/20JlV6aERL2/2FqHYtMiZ5HpvAAI0vOStC7+9u17xZ8vc7y+s5UJ45e9D4WPNzCLfLBfal5OHqLLQUK7q8jxXPGASaRy3WVsVz6WmTWVxvVu0n8GukSPO3IC2e3npJk6I59WuPCd0RdFfU+K4ApCAmqdqRQA8y0hI8snCukJtXzTgJy4IU9MT6bcd4NG5PRtuhJL8YGoph4Pw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1612820612; bh=saQrTdUrBa8n6Ze1Qrc07ilBGnPXyL6rMX9qDfUjcNl=; h=X-Sonic-MF:To:From:Subject:Date:From:Subject; b=f6aVxQ3dEJ9iIoa4PXDPsdRNk5XvkID/m59bbT6xDBVd9A5NcUWcdtcNGXls4kulw690H0cETOc4lG0IRfDgQhV84ubwGBjBVW5zlqmQ/fRsD7XrBElNi5cH3dyCyWmbmH6Pexa156XqR/4kkWJNubbQdDCwt6DH8m9P9u3DfPIFEbMn/hcjw6tACAxoUyaWgZd7ycgVWR7fcNiGNJvIVEuxRQf2SWrccXGESCgwpBCCVCwIXlIvSWBOgwpwSuAWHtMz66uaGqo9RS+ebxtbDjrzAzHIrTnkthY2+1/07R/15j5Q6t0xvls6SFD9goFI2DvuHy4u9Iub9wztxdMVqQ==
X-YMail-OSG: 2oiOWv0VM1kfflEApYDib8_2sDhUubyA1I6db__LZb48mN0H1b8u9mLSZX3XBPU
 nH6NuS1dfkKJOFzGdhjdqclu7CjTfoe1TNEWg11B3pacLHVUAxCgNMCgcLeWOaX_nj_ANzKrRMID
 LwbQ2gPlQF2TPNzkvko.BRzkMFwphM440b_EpCEnyX8UjVXKG1l3FSwmlP0od6PqB08V6a5AsvgN
 mRPslREdIojszFwLqJM7J_NrjNCBvi4h0m9lC6aoyfxbvnKJ2g8QFK3UnP3Yb3h3._XI5UgBHIej
 sX_uLAwpp2n05F7GR.oBrdGmFofPZ378VtLcO0eFHUUMmxvgH_xry1aJfiEFA7TOBqvEOrSPEgEV
 Qww8uK8xcGh7LzqAiD.iKy1WV7JexAl7oqRfExngNsQxyaWx.CqZ58i8bCUkNxXaGQDVgdKjselP
 iyIzXq22O2Fr3Ah1UDjW0e9xoERxb_4Zt4AspAB0gWFRNiUW81el4jPIhSBcBU7XtuH.sAtkb3NC
 1gbrC9RwU4psL90Q6sKBMGDLsmtZiSXQUNxPLrdXBXGg19W4bJhkxeDKuGwcYOIrT5UZz6dofG_q
 dU3JFV679xZlT_NTaouy3rZNEHMV4nhYXgzyY8RI_0cQJr_xOBC_7EGA26iJdZNhBUj7VyEARh7L
 JqTT31tFymG37mnji1YUoTSGgeOmn.YAev.bfvoRbILuFjY5Q5V1QYn00eUi2_vBGD7iJaB2Tol2
 3SpR3VLiEwSTSsOnl3KZSQj3tdvyURyfWUWOhS2w5tJa1zNMXXjV1LokYZA_Zw40ASBjZMcE4YYb
 8dLZtSDg0dOkkLhUWHqoEBXxsY8dzJqPikY2bLLNtOIH5DrpvEbDWC9bNqLwAUI8sgCb0aVqsgRk
 iqwoXe5AWvq30WTYJQ_XukgbJbvLBhyD801LqysiK6ULOooSE6QqhHHSBVX8gYsbEAlXsaeyszNI
 WVUQV8w3oWtRnnnIChfZTzr1cb4otcVDs_A18IutpvdyZR0zggZcEnQOxjaP0SR3Jh1lRXABPf7R
 lPE6yrIzwid9f.ZM.yOJtIH6NsxtCUN5q2piGZ3pUjN28fWBjUJjVTPugqNC1AkRXvR3abEFHPfI
 hgef8BMUalt2msFG638TiPJXtZVkyj.IaZNhJnNk0DY8aM68WTxukmbgiMB_PuDptSpVPIyd1KZp
 VWUGD25nOfnKASz6J_JJ_FW6ycdQvhSHIbNUYdq116N5KJADOiN7uaBOUp8GSYK8Tx4bAb1WeQ3G
 gVXqDAgDVNvoLawiu6eTDq2cjm6MdtjCYCaUYn83B9zxd45KEg1y77JRroDyWozCOYHl3k5K2RYR
 x3xCHff80yAZ1mscn4Gq4As_kvYQBjBH0xPDIKMYE1ulkkAY8W.P9n5xOUmg1t.wdZxrEO3iDCZg
 t9SbQw9pSQpdDBA8hirne2m5.oZ0my3icB4ViFZYJNJ5cIkpmabB9nSySu8bSTI3Iw5qIyjArvnF
 WoTl2eKAQ6VXGoiPTlWXStMUtJ3Jzcc4e6gPyFyhQGtwvBV101qfTdGQFXAiF5QTkGZ1hCvjGzXw
 T5dIq7Vjk1nNDtdKNKzHrfAMbpfXyi3YLvaHycot4Ld5ONWh.y1zupI8vW1KrvewBKWofOSO5Nsw
 4KSbjsqrgSZeeYRMwukJCjvoW84Wvc0GNkwxOytLGSmfyBAq2HG20_ApqG.kclCVSPU3KzDmplt9
 c4GWWAzNxmEoXC0CGFsUHZaBnkLX7j2UXUArn.31Z4iOmrkx753ef3rLMgertpRxPWWKTMwlCUfh
 e_2qmAtPI_q5lR1Z6.1r2XC0da5UET_zIM2R00vakicr0Zh2pDwKL2aFyCA.wP7xCrVpqY5FBtZt
 zEJIqB1aGt9_nJz9XfHzY8hpwc9vsNi7EFoWp_w.NFuUJIzfbpGVG9n4I8SpD7mX0zJsOTFy1pAa
 5XjAq9kvJm0s_pcn3Yytzezu9BzVThUHMiC1z2.q5CRpdx4.omOubAF8_XJPvdEVCdkDMqQxntO1
 fr.1iQ9aRryc3Nuwc9bGgNexXJUw4HOHwPAf.U4I6.8F3cXU14AlpYiTQDmYwjY79Nh6t.0wn0wL
 WflBlOSqmR0.iRalrXrUD11OaxIeMkAtKkj.spToTVZHoL3yjGaHEYRO9HeP6hHengcB8pPqCaNf
 mHDj5f4A7XYgJ13kEY2Xa4IeMR_0zHVumz2IIFpfsCggZxiKNOjIZSTgQYstwnSAxye79AAWpdJO
 izd3U8ZwQxk91sKQ9FwY_wcczkG9nP8tyvnw2TuxFccVBkCr3kvX8k0whl2hiEo_of3UdPlADSsJ
 wRElo8JDS4nCnxk0Jk.FhW3k6yGLA2f6uWfaS7iI6ZthBa34ZZpq36o1Mm654_41uonc4DS9GE6F
 8FQzJdMiJ8m_cjeYnMqlJGGFQVObDSXcV0U.Vd4s5No2sUQUhHDy3IXgB5bjrW0IwVCI37YdrVXc
 II1ssOK9O8dHIljM1hYGo4s02pTStX0NEBMg0FY1zWuzrpMbDy9D2y0ksrlYdKPQn1JQVfvTYx5w
 KTgX5s3qf1TqydO7aZTeeGuYGycB6XwdWpalq.rk2xF2okG2NPCvmZv8-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Mon, 8 Feb 2021 21:43:32 +0000
Received: by smtp413.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 3ab884bd755ef28333d2514f7f874e14;
          Mon, 08 Feb 2021 21:43:28 +0000 (UTC)
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: Reviews on v24 of the security module stacking code.
Message-ID: <950c6492-bd6e-d5f2-1ec4-86b47c6ea9b7@schaufler-ca.com>
Date:   Mon, 8 Feb 2021 13:43:27 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
References: <950c6492-bd6e-d5f2-1ec4-86b47c6ea9b7.ref@schaufler-ca.com>
X-Mailer: WebService/1.1.17648 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.9.1)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The LSM stacking changes have been significantly modified
to address Mimi's concerns about "label collisions". Would
you please have a look and see if the issues have been addressed
to your satisfaction? I have introduced the boot option and
policy specifier suggested.

Thank you.

