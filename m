Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B36B44065D
	for <lists+linux-integrity@lfdr.de>; Sat, 30 Oct 2021 02:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbhJ3AVf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 29 Oct 2021 20:21:35 -0400
Received: from sonic317-39.consmr.mail.ne1.yahoo.com ([66.163.184.50]:38060
        "EHLO sonic317-39.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231169AbhJ3AVe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 Oct 2021 20:21:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1635553145; bh=2TXmBMXhYeowVcfDlcIVF4JHj+lyOvy/Xrouzaj4XMg=; h=Date:To:Cc:From:Subject:References:From:Subject:Reply-To; b=HwT2VBmg1cEBYzV3M9g65kTZVyH+q+SbFw0dLpyJlPX0tuQMqpVgMtmWKnHZX2sfGrhw8zJJAeyIE6IvrtXIXkVuct4tjdFbjts2VaFVKEIIyakz2HcxbJ7U3NERyp9vZJ4SZ2+n6AON/Dhscm0SQgGlURdpdQljRxxyciWXupTvlUqP21OFYM7EOPMmuwnkzNGijF13+cFb1K4omAKcPaBG9TP7IrLk87gcivcXzv9jAY1iigI+boLg02tFfLHupC0TZANK55ekYVfXAbC4MYMCrPUZrYNoSNZgV25vTDSqch4JXxsz+qMwRDtBsjycBgdI5fU9PQaPsueNrVp78A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1635553145; bh=SDG98R6aTpp93Kp42w7JvRpcjVzb3qi6sX9F9JJHb5I=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=GNwZIZmGr1udALViVxXcekEsQrC+lvGWCv0SxcvztdHvUd/UZJoL9dKO7TIEsQfZW0O5URbdOqrxXrNucULc/RAsFxgGHWuhq4RbwEY6tG20RaWsSB/8pox3oEE7Ce3GYZDbfxJMSTQFL5rDNKLhs1GSXC8Hn57OpIvrzM4CwYjQANURq7blql8oObeeGR2JNgHpqOZkjxO8IJf9EqomIWsgDUUvXzGdd3OhyTmqp0h73jJj/Swax9kyYm8nWgkGKwB/nhexXb4y5nOXeXCmFRIBpS4GpQ/jtpg301lTGUfB+yHxX6tne4ZjcYB4MIOyGRdF2piHNnGu6opFBUwBjg==
X-YMail-OSG: yzEsGJ8VM1lSGj_6cD0oSdHLJMLipF0zcoyjEhpSt2rLb1k9S_F1TRLBkBdkI5n
 _DXaPDUZa9KZWEER1n8MlarSWebcAHsXHbOB0fEbRAXKfpd2gHHbRr1Aotp3LNRhieJBbEoX944q
 1I_ugaSnyhupdGX9X8wKbZ6VCTPlYzrarW6HCV8_5Dc3cOUhltVYykjmrxz1PdDXJ0YrvFzvyf7r
 G26gAtUPVQtwpVLoi6MkLILnA66ytfv13KTk2eg0yyoLVSYl58Hd4uDc6MjPiJ1GASN9lwHCZiV4
 OXA7vJhUG4I5eLkEnT3ddHk.d4iadWmM38ZXsIgs1fSWtmxv.YsXjS6ZE1ZdrTg_6S96v9_eRPfa
 iDclOTrFQb605LdV4lo222jXtsubart9dhRO6Qy3rZIeZf1zJmKaNxPaN7BSeMqoNVzkCbTn9cZz
 hPoygnLKFLjEoGq9eoA_2ASaoZLituZtAP3Z2MVWyfTrAamvwgJ5pXKmEaGN9HRM3WZ1QW3zpeAj
 pq_8gA0hQpleg7fdnwIaijCZ54nl4VN0PiGaaX9Fr2nIHYSY264ZtqZnRUkvVaUumsIs0fwpxgB8
 nB.xd.0Alq5RNHu3VBU5MQjgpVGQb8IlayqTVWpPRYZ3MqZQDPQqLnjQmcahz4TBlv8zVsNUnsdq
 d3aYGIyr4WQKKemIW55WBU3IFPfCmWsK9PijiHa6.PnmAyUriGaG4211d4EfuZmgfEr.kaN4xtd4
 5MfmyUJrXBxtZtntLTuAzq53RD2f.V1crLt9HfdoQbRyBXaRZ1UBjdNp_MB4W6CfMWoWH2_.lJgP
 i3CpaahCBjRW.3QQ0dNr0_jciZ6TIp3USHAQXi1Str7uISAnOA68USP_5ZC2vA3ZiS_Tt7r.tW3a
 XxXt2tbj.5fRspSE8ToMU_2BN3hDgJWqzwM0SS4Fa2r5ldC6slx8HjvY1aQE.iXNr3tDSWhV8_3P
 Zpeq_Vfkid7unQrDUMavL2IBp3eM4o3SnpGLP4cnbgyS2QVI7R5OsKIJMV83Izy.sCZ4Tj13897_
 7MoGNlIXPo7kX6_HfQigSA7FST_vmzK33ElQD10NUnttkN0hWvEYwmb_8gYppGrc0LZYZ6dpS6Jg
 SH5p5WEZYasLiNTnFACfUDEzgW67phBG4UOaMnGuBnHwaAMoOwLETz7KU76UKlHdIC9q._Ye5aa7
 4y5A_b_6H000I5R9sxazulDa0WugqUG.HyvduKjGJrnPeF_zc5qc9UwO02RlLqhJnFvNizvTxhZW
 xR1BIlN3yZpWnP.D29vAyTxqR2_kFr9CKZw6iCLvyFQve.QrEu4DdlmgUtwYXG4RxAwnoX2AkMZ.
 PDdSMzrhPvwlPx7X8L8zUeESbQ3ovRsR4DENBDvbXS6purIsc6JGZzLYRMnPqksxSdRmHBlS28rM
 EnVhHRtAJKWl1o7bsBikd7wCtQi2Is3iMNOo1RQtM9ipIhDqxYS4b4wp.fAdsbXU1Aw5R2wYKNvG
 AicJYxx1ahOXc1mUXNocOwQNYTpQmfzFjpBjt1GfmzEHsfD2QOiKbUz7DxyNDpdkOW_MLRofCR4K
 i2FYwlc8DXhbfGU3NiS9daFUY_x3hCk_86ERcSyUzrcBXtdNC3rNLO7gsxT.itjQC98hV67nOfcN
 IKUDR9T7CdoxpHfwT6igiFJ.Gs5pZQgmc2IuFVarwkXqEdl9DiV1ar2rWEfV4RHTEjxtxfkvtdEg
 y5Phff_FhEogg.wlb6Pnt7CB.qnAesI7Np_l9WLOvYdTyAxu0hjnIk.xQEv6_LxKnLzvKuiydlbC
 4.RvnWLVvWe7.2Dh0OJmsqvb9Db3lgcujg1zQxQDcFwNQMxJPwQNydzJQhxgfWdP77R.9.2Xw7oW
 q1Qn_bhTl99JvnF6mJmw2vrY50ajPEC3B6BQUyegH9NSZ7Z75jSLHcqKDheOEnYZjT4_GlPYvp8G
 Cri0Cu7of9Y3EHbPS78XyrwwoQ_mhDyCLy59F2.Zuh0my4ZWK1zAiLNc1jJAiPdmRVP582z0Obl9
 KNfyyFIwk.R1Y.jWPaWrB9ynjiTWO7Vgbp11J8Ne3Quq7JjANDWJJsTAVSEZznlJ_.8EhYPVbYFN
 e.Mgnwa8UeNNIZHSBidyKX7bp4yjRpruny3P0pb7xS9BTKLM5y2e3oC.LnWx2zavyfPns8V3WVUO
 W0h.VpHrnjZdYwNNb9MuTYJ2D166elwHPAB7wLWAJvhBjcLp5jxrOCjqhrz5F3D1Oa7VfUlAry0Q
 7SNeytLBO4fobybY-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Sat, 30 Oct 2021 00:19:05 +0000
Received: by kubenode511.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID eafe556922b36a4984895cfd4f734878;
          Sat, 30 Oct 2021 00:19:02 +0000 (UTC)
Message-ID: <c8012c58-6cce-1d17-902e-a9e757c39822@schaufler-ca.com>
Date:   Fri, 29 Oct 2021 17:19:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Content-Language: en-US
To:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: IMA testsuite?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
References: <c8012c58-6cce-1d17-902e-a9e757c39822.ref@schaufler-ca.com>
X-Mailer: WebService/1.1.19266 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

I'm having trouble tracking down an official IMA testsuite.
Is there one?

Thank you.

