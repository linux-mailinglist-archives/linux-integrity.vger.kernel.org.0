Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 929E612E915
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Jan 2020 18:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbgABRHC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Jan 2020 12:07:02 -0500
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:39657
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726125AbgABRHB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Jan 2020 12:07:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1577984820; bh=r5orLb7Fc0M0bzCZXxJ617W4MOBhU6G7hBUAhMiqVE8=; h=To:Cc:From:Subject:Date:References:From:Subject; b=fsY+72uclYFov/e2ocr7Q9NfcKfrlvthh0jV3OKxYP6ZruXJLcVebNVG/kk5EgOeAELp5drj6LSXnR6TkPjSHW5RriAQQYMpm8QJ84zDWKm807sjMP9YjYsJqVaLeoLmIcH0hbKFXHPIr480HrWmXcZo0v9Jc2WzqkMu/HlqgVB9zgrz5CPMdCEfAHkEkMxwNTFWiZgqetAFEm4HurxvjRyFPhkc9R2fokDu91QJWp/IpEMQ01hF3AnQceCuIyoGVb+AoHzVCJZ2oKHbpMUSnZU3NMSraBLMSqFbWZmNTfhEEyO1Xa4txtn9kfYDD7O6DmLkAM+E15844qDLImSi4g==
X-YMail-OSG: _uuim.gVM1nbF3btHLcUwBS9MzZl53TgrFPoMp9ENnlg0l99MmzvuBVT8_w.wDX
 pXZblHenH7JbvHesZFer1xGW26FGjYnnQFYBRLcNVbcwLDddjGanpqNLfQ6vk00VOg4bLvt_0RXy
 Qitx8wtY.DQoE3dTe7LEx1M3tKrVUOZovcyMHiMq_5ez3ZuhCyVo_H8stCPt29te6ltepuwBfxjR
 hgy.bhcHRS5tKcJq4ZrjP_9Z100jCINI755HyOs3GdHMk_3gdymndx8AYNFU1GSAkdMx6_Uodg5p
 dnkD9PQvTEDHw_InaKUvzxoBQUTC6x1EAawCCG41XFo9bIT653nB.0UZwIdUdoFdb4e5kE8mzcNC
 hDjSfloWIF2yI_W3Z3kQ7xMKCWVg5MP8OZOn20rvivAnSuzbdTn8JD1y6vrN819v0l7YJkWHW1C5
 gFuavhK8egFo008vDLYaa2bIIWQ6VPNuY1uKxBFeu5nJiK0jjC0lw.Psro.ZfQJD.L0T2bziRz9t
 wEr1xszE.r2XCEXm9sHxCFqOp0nFy6oBgyA1xp4WAUoCQQO1Ey_H_CMVz1MpV50XUjYXrA4CcxtY
 1oJg.f90DkobEiTP.L9_pgNjzIDv3PvjwhB3mzWjdtvP_nKv0kkFHOej3tyj47tLZ0EeXIJ5gf0r
 JzJPqVUaMVDHjM64CLAW0nqvbRdvnif62g6K4JhWv1JkxM3Yh76epxRp04E.KS6Os6COPiJ8iWOz
 8zfnOUddY4HY6yb7oygKGdWrEoMrtE0P7ERCB8tg7VDpJ.f07_ey2uN2A7MVOY3.fzwzh.E.PX88
 dmptOgvkJklqDFUuZP1EIrkF.9Y6QLeawbw3vsSDd6ZEHutlUyXs1fsdCDvr4aYnw9PC5ygPE5ch
 09o.WgPocPtuYlZRDKr3vYExX.PWhyYPje28nCmiGZO_inGWAKaU1LCDEcQMNWY3Hw8GKFTmArv1
 Q4mjN82idbNUynfCxqfj5w7z.Mu9m2RlIzoFMNwgGg7LVwtnlNyRHJthKPJvq9uOCl.IPdHV.G12
 brZ3uAxUuLqR5Tm8Yis4Lru_Un.OtC._yiXCbCI6AEYbasGqZU5nqWldC4aycPXGrLMYLVopVeGg
 DcZrAB5lQC3egjgjTqBUMJGCA0WJUh44WwXUchi3LZ7rkVB4vupR8iq7bUsel6ST6XhuFftL39T5
 HVAlZf3oDXsBlX7V73gi8XkhfCPs9mNC_K3C.f_8UWgrJ4rwgqjWzq2KI4e0zISN9NTarNawGKOK
 X68Qi.VGDE2eZQ1b5tojyDl63EHg5mjZFgz0sB7baWf07iDwVhOyEZLSD9JnRQsV.HaBb_RSmsYa
 s0Lt2jcchdwOMjhFNc1bCPRjoZWSjgvxQw6YXh6Y.dF_5sW41lSyNkfTFgw_uokHDA3eN2pL.R57
 II.9LjTJU45x0lVS5qSLKQRpzXnsFtQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Thu, 2 Jan 2020 17:07:00 +0000
Received: by smtp427.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 5ab1f7906443f3fa9d2a20e07771f142;
          Thu, 02 Jan 2020 17:06:58 +0000 (UTC)
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Casey Schaufler <casey@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: IMA's use of the audit rule code
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 mQINBFzV9HABEAC/mmv3jeJyF7lR7QhILYg1+PeBLIMZv7KCzBSc/4ZZipoWdmr77Lel/RxQ
 1PrNx0UaM5r6Hj9lJmJ9eg4s/TUBSP67mTx+tsZ1RhG78/WFf9aBe8MSXxY5cu7IUwo0J/CG
 vdSqACKyYPV5eoTJmnMxalu8/oVUHyPnKF3eMGgE0mKOFBUMsb2pLS/enE4QyxhcZ26jeeS6
 3BaqDl1aTXGowM5BHyn7s9LEU38x/y2ffdqBjd3au2YOlvZ+XUkzoclSVfSR29bomZVVyhMB
 h1jTmX4Ac9QjpwsxihT8KNGvOM5CeCjQyWcW/g8LfWTzOVF9lzbx6IfEZDDoDem4+ZiPsAXC
 SWKBKil3npdbgb8MARPes2DpuhVm8yfkJEQQmuLYv8GPiJbwHQVLZGQAPBZSAc7IidD2zbf9
 XAw1/SJGe1poxOMfuSBsfKxv9ba2i8hUR+PH7gWwkMQaQ97B1yXYxVEkpG8Y4MfE5Vd3bjJU
 kvQ/tOBUCw5zwyIRC9+7zr1zYi/3hk+OG8OryZ5kpILBNCo+aePeAJ44znrySarUqS69tuXd
 a3lMPHUJJpUpIwSKQ5UuYYkWlWwENEWSefpakFAIwY4YIBkzoJ/t+XJHE1HTaJnRk6SWpeDf
 CreF3+LouP4njyeLEjVIMzaEpwROsw++BX5i5vTXJB+4UApTAQARAQABtChDYXNleSBTY2hh
 dWZsZXIgPGNhc2V5QHNjaGF1Zmxlci1jYS5jb20+iQJUBBMBCAA+FiEEC+9tH1YyUwIQzUIe
 OKUVfIxDyBEFAlzV9HACGwMFCRLMAwAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQOKUV
 fIxDyBG6ag/6AiRl8yof47YOEVHlrmewbpnlBTaYNfJ5cZflNRKRX6t4bp1B2YV1whlDTpiL
 vNOwFkh+ZE0eI5M4x8Gw2Oiok+4Q5liA9PHTozQYF+Ia+qdL5EehfbLGoEBqklpGvG3h8JsO
 7SvONJuFDgvab/U/UriDYycJwzwKZuhVtK9EMpnTtUDyP3DY+Q8h7MWsniNBLVXnh4yBIEJg
 SSgDn3COpZoFTPGKE+rIzioo/GJe8CTa2g+ZggJiY/myWTS3quG0FMvwvNYvZ4I2g6uxSl7n
 bZVqAZgqwoTAv1HSXIAn9muwZUJL03qo25PFi2gQmX15BgJKQcV5RL0GHFHRThDS3IyadOgK
 P2j78P8SddTN73EmsG5OoyzwZAxXfck9A512BfVESqapHurRu2qvMoUkQaW/2yCeRQwGTsFj
 /rr0lnOBkyC6wCmPSKXe3dT2mnD5KnCkjn7KxLqexKt4itGjJz4/ynD/qh+gL7IPbifrQtVH
 JI7cr0fI6Tl8V6efurk5RjtELsAlSR6fKV7hClfeDEgLpigHXGyVOsynXLr59uE+g/+InVic
 jKueTq7LzFd0BiduXGO5HbGyRKw4MG5DNQvC//85EWmFUnDlD3WHz7Hicg95D+2IjD2ZVXJy
 x3LTfKWdC8bU8am1fi+d6tVEFAe/KbUfe+stXkgmfB7pxqW5Ag0EXNX0cAEQAPIEYtPebJzT
 wHpKLu1/j4jQcke06Kmu5RNuj1pEje7kX5IKzQSs+CPH0NbSNGvrA4dNGcuDUTNHgb5Be9hF
 zVqRCEvF2j7BFbrGe9jqMBWHuWheQM8RRoa2UMwQ704mRvKr4sNPh01nKT52ASbWpBPYG3/t
 WbYaqfgtRmCxBnqdOx5mBJIBh9Q38i63DjQgdNcsTx2qS7HFuFyNef5LCf3jogcbmZGxG/b7
 yF4OwmGsVc8ufvlKo5A9Wm+tnRjLr/9Mn9vl5Xa/tQDoPxz26+aWz7j1in7UFzAarcvqzsdM
 Em6S7uT+qy5jcqyuipuenDKYF/yNOVSNnsiFyQTFqCPCpFihOnuaWqfmdeUOQHCSo8fD4aRF
 emsuxqcsq0Jp2ODq73DOTsdFxX2ESXYoFt3Oy7QmIxeEgiHBzdKU2bruIB5OVaZ4zWF+jusM
 Uh+jh+44w9DZkDNjxRAA5CxPlmBIn1OOYt1tsphrHg1cH1fDLK/pDjsJZkiH8EIjhckOtGSb
 aoUUMMJ85nVhN1EbU/A3DkWCVFEA//Vu1+BckbSbJKE7Hl6WdW19BXOZ7v3jo1q6lWwcFYth
 esJfk3ZPPJXuBokrFH8kqnEQ9W2QgrjDX3et2WwZFLOoOCItWxT0/1QO4ikcef/E7HXQf/ij
 Dxf9HG2o5hOlMIAkJq/uLNMvABEBAAGJAjwEGAEIACYWIQQL720fVjJTAhDNQh44pRV8jEPI
 EQUCXNX0cAIbDAUJEswDAAAKCRA4pRV8jEPIEWkzEACKFUnpp+wIVHpckMfBqN8BE5dUbWJc
 GyQ7wXWajLtlPdw1nNw0Wrv+ob2RCT7qQlUo6GRLcvj9Fn5tR4hBvR6D3m8aR0AGHbcC62cq
 I7LjaSDP5j/em4oVL2SMgNTrXgE2w33JMGjAx9oBzkxmKUqprhJomPwmfDHMJ0t7y39Da724
 oLPTkQDpJL1kuraM9TC5NyLe1+MyIxqM/8NujoJbWeQUgGjn9uxQAil7o/xSCjrWCP3kZDID
 vd5ZaHpdl8e1mTExQoKr4EWgaMjmD/a3hZ/j3KfTVNpM2cLfD/QwTMaC2fkK8ExMsz+rUl1H
 icmcmpptCwOSgwSpPY1Zfio6HvEJp7gmDwMgozMfwQuT9oxyFTxn1X3rn1IoYQF3P8gsziY5
 qtTxy2RrgqQFm/hr8gM78RhP54UPltIE96VywviFzDZehMvuwzW//fxysIoK97Y/KBZZOQs+
 /T+Bw80Pwk/dqQ8UmIt2ffHEgwCTbkSm711BejapWCfklxkMZDp16mkxSt2qZovboVjXnfuq
 wQ1QL4o4t1hviM7LyoflsCLnQFJh6RSBhBpKQinMJl/z0A6NYDkQi6vEGMDBWX/M2vk9Jvwa
 v0cEBfY3Z5oFgkh7BUORsu1V+Hn0fR/Lqq/Pyq+nTR26WzGDkolLsDr3IH0TiAVH5ZuPxyz6
 abzjfg==
Message-ID: <a6c15a35-a8cb-7589-7960-a19e788b6c45@schaufler-ca.com>
Date:   Thu, 2 Jan 2020 09:06:57 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
References: <a6c15a35-a8cb-7589-7960-a19e788b6c45.ref@schaufler-ca.com>
X-Mailer: WebService/1.1.14873 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

IMA refines security_audit_rule_init to security_filter_rule_init.
I need to understand what, if any, relationship there is between
IMA's use of the audit rule mechanisms and the audit system's use.
Is this simple code reuse, or is there some interaction between IMA
and audit?

I'm trying to sort out the problem of audit rules when
there are multiple security modules. It looks as if there is also a
problem for integrity rules, but it looks different. The "easy"
change for audit doesn't fit with what's in IMA. If there's no
interaction between the IMA and audit use of the rule infrastructure
it's reasonable to fix them separately. If there is interaction
things get messy.


