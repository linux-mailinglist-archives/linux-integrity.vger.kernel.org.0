Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D929386CD6
	for <lists+linux-integrity@lfdr.de>; Tue, 18 May 2021 00:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238403AbhEQWTV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 May 2021 18:19:21 -0400
Received: from sonic307-16.consmr.mail.ne1.yahoo.com ([66.163.190.39]:36795
        "EHLO sonic307-16.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235143AbhEQWTT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 May 2021 18:19:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1621289882; bh=mibVXlbMcWaUfonnFpx/+11EgEx7379ucIbJ7Qkcc7Q=; h=From:Subject:To:Cc:References:Date:In-Reply-To:From:Subject:Reply-To; b=pVAZWEx6p7X4OQqnCUkr1rRPy2YTSX/abTUnZt7+C7QGO6YirYwJQpKHmBqKyvLWLeAbJdq/YOFVUkwBMs00C7uIZV/uSpfuVyhGMYlrljXxBUAaKYX2oGFK/22Xf2ow4k2/NOVwfyvvopd2VjYKgzpx0mpIvO7rGvOZLUNIXAoGVTpLfKE2SGNMt7GY2QRxzYTsptDj6+lq864D0E3QSEBDu+dHtUL9E3akOr6QWP2lI8zLx7AhbCZVNUOyl8ZLcpKUS+6nWE42Xgdk7egvSN6/cDwIcvPCv9vEFAiBDkiyu0iWk95oUxCIxpCQAXEo3vj5+2lIUuq3Yk21gqbwzA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1621289882; bh=aTNzi5ybfVlgCEDFPMTTgL6CAJ1xqic90LyOV5HbOsU=; h=X-Sonic-MF:From:Subject:To:Date:From:Subject; b=uSSBKyiXmdf4HxrkbZFNP+y/MiWa2OPq94XiJfw2DX+yeEEUVQo6tFjWZu3WckuKrUaoKnBfC2ZPH4bmr0vw2eSj3yViccp8i4+NevWoCyaHlotk1QLvwSLJhIzUIC8Oj8KlAzOuMQnmXGkk9vZywfj03XDVdEsWPr0JNR8ZuR60gx6RSCc/uYEnfs6GCvchMB32eDfLahVwNncBt6e5XL8zUMcasg5CNGW8O8+OyJ0vWxlbeOELuF/3s6mBt31BWZ8mSEKOkFfDaop0/sI3AeHhgRQv+LXUnYomi1ppSHjeDliSgWsw/1bOSqUdiBdVTFDUob5qGAoHVMo847hhBQ==
X-YMail-OSG: HajrbTMVM1l8POfjry971_7OcGHrmeeRDhh4GYOdne4HEnrKTBLu.U65A.RM3dy
 QGnxkhj6_dEolmAonXIFnZ09YvpYuHEsuQIjR0iNwxyL5KlE6XwZxBpRShm9vspSGp81eCjBQ4gM
 ogWwCgUdd39B8PsyK0oA3uueyQOfv3r1TdpSV0oIGbRyvmZZlBEUwevF03nuWzMoFnNhxwJ5TEKF
 VlC0wXeZKK3z0BDSFwHD7mmY.cFpGbJScUEsptBo13HjVIIfIQXyzKsUtQ_xVc_kM6_JtcOseAH1
 yWkNVYcjGL8oKE4iEMz9EuWCfEMlGA74McL2wU_PvowFn9hVlm9vY3yFSRcsgsHk.iIORH.EFbDW
 1juwllHcViOqEoqzA0PI_Pw2aMWQlmEVm0eHRluTH6Wgq2LNnvUJ6YBpenzOXWLt.3_j7XCz4jQf
 9FMNX2jamSFXF7OMmaN2qqouhfxL6j_oOLc_lblmxEdr8tG4IXszPDPqCbol7MP1_twoA4t3B0ix
 _B51mEkA5rhH8Pa2YCiIReEOq4XgNbw9H4c.iXTzYN2FfcB6L.TQeY2_JuXbxRIHEewpEjhbPnY6
 Er0Yn32q30cT.Knjxr94RRoQg.s7HaNRi8yM9nAJ3..JSQ0HDVZXmM5Pa6USv_TjZgFM46PyaW.s
 VH1JEPKEaQwfpMD5vvQtzigcdI6KNOD4NYqgyoZPQK9OBPG6BNglAtBvFQSNxHL2qiBdhOHiJzP.
 8U_6r1g5r6lUlTSk3qaEWbKmFTsxzzzUolW8FvlZWLZyv1J7V0nFT__HXNjgD0Fnulmu0z7yE5cg
 vOn1QR7p_KYhvX_fTYERExx0zY4ZkmI7xkd4rhH5z4X66BiqU1CttGH8Gb0q9J_KyWFwnkhmSV.0
 BTU8.nWVTTGuMuCiR70LSvG1dxWeUeq5gLKbhwmOXT_bnU326PG2ccVDotLBWgpLMUesx6bcXY6w
 5dpOThV4r8xCWQ2xfYEnE4jAwcXcD937Fdxw56zL3nZ7r4EOBebDwgz1r51C6UcSxjh4Olcw9PbJ
 6i1PeLu4Yi4DLtLwcLZfXuF_VYvVO.6I_L4yOaTCkh3FxEPuPprgdzZVgIFBIlJbHK5bbvRUX0GN
 dfZmSe22Lrxo_LV8DYFAhN7GStMLC5k_TU2WjsjAqUQjIhSBST62tiXfTs6DmjZj5g8KHWwYVjsZ
 OjqRQL9ROt4wlbf2QFFtY3j2hbLspZVXSDq_g.UFVKL75dm_PpZQsOfOTLyKqetHq1d1Kr1XAkHt
 pUbOsxgAj2Ux3BeqCbEZy_t_N9t7YIAZN_vXK821q_mx6FmmNHJmggH6dVlgzOk.2lO_oOYgO0ol
 DmcF8oWcRTBlmnzAC9ZfG1l2NL8DneyItzdz6F97uv1ts9ERxMdCThsrE3aIzi7tceXMcWOW8sFQ
 ErMB1suu3W8ZSX0kfswT4p43Kmry5LswCvTBeJMVCJ4BnD_AkoGYzlFbCG.UOtMEx4IYmbyVyPwQ
 ubNMbXuLjCiYM9_upHKQIPyVe1WVudFJh9XK6.x5I_eaH3wjdy0MXsO24umntKcTjtrqp8Edqxmg
 x1_h3gwqpYQE4_pXVMuzMjNnnMONOuqYg.0uegG4ZBAf1PzwHSRNLITfh3CpcswyxjnS0rEm7crH
 WdgLicSuIHpf6YftSf5ZVzhSuET9gyU4Q3vwRpYAj7Brutr.1quhW1qaE.pzFwGTlKe0xT4D0oI0
 u9LRtycaZfvdv2hG6D1QUPv72SiZYHSVA3hmZj3dMw3hRnKP4J1njajaI4NJr4FRV4U3krAjBW5O
 U4NDXQUbPD8wRa3E6rGrvZAPhE7FAuZP.cCXchbkmR4c7bU.vLFqtLyw1hMQUIib7PFKGBioyuGq
 ghBZB5cAMfwHyjDpFw6oxUTeBAz2AY.67Ais5t6B6kcHvgHlXMBwCCqXeI3daVWmAqhi2RPwWxIn
 pewxTEQuPK1mcf84xXLlIj5mI5ho_SqwYQ4JeKHI7I.85vJ.b.BQVtZnpcjetwvPlov7nQyH_UVY
 52k_ughsGEm_8mi4OplG.v.0kYc6fFGsxsCZGqzfzI1B95ba_HmkuOyIAs4N0jVZQKooyVGwST2X
 WuSb1LT2M4_UKAAcqrcSSqT7_8bwBDcH29FTn2uD2_JpkjRhL8W90BE.sY3EWixw0yYSmCTK6bw6
 aOND4igUNUQEgoKYaTh6we5NLeUz6siJ2tbFQZrf2j.UODzLYIZpGkdXAqpDSOBMS04oFZSqNVtE
 38n25K15w0xS1eIDqu347w67YQ1F.FeXC3pVAdHFUxzGrYVmBotibVCxzVonSnr5sFeTiXdE9H3b
 iZoRgNXIOf2k84UwMxQAELKTgIX6qRxxJ5lpOAGiXG7wgHuzQukWg2TSEP3p30.n6X2agfIN4v5O
 4hHGVhwxAVFI3y8RoRdEhOxB8zeVBu.dtp_UkQlWoOWmZtJHw1Bjs4phL6.Qe7nW.5xFuvN74aq7
 6WO8Qb0AGk9uBlmof8JWc29HUh7HFtBkcHaUCbrJJ734LBfAf6PGlDLxmhB8REbu57KQS6k.jPSc
 5kI.8owtd_I.dyq.HEiC96dxNN8jf6unKFZikOuTh0G68.Wew0ZhSnBhF36LQjYRST4AofJvPccH
 9XyxC
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Mon, 17 May 2021 22:18:02 +0000
Received: by kubenode510.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 98cf1b00d76d84f69bdf36475e8481d7;
          Mon, 17 May 2021 22:18:01 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: Changes for module stacking in Linux integrity
To:     Mimi Zohar <zohar@linux.ibm.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>
References: <9cfb137c-6066-c1df-1619-39793b0d2841.ref@schaufler-ca.com>
Message-ID: <b62729bd-08c1-7f8c-3564-fa63af2a9dea@schaufler-ca.com>
Date:   Mon, 17 May 2021 15:18:01 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <9cfb137c-6066-c1df-1619-39793b0d2841.ref@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.18291 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/16)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

I am putting a real effort into getting the current LSM stacking
patch set into -next for 5.14. There are a number of reasons, ranging
from moving onto the next round of changes to pressure on other tasks
that have been piling up behind it. It would be very helpful if I
could get either sign-off-by: or significant comments on the v26
IMA/EVM changes.

Thank you.



