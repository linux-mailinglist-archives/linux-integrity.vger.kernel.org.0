Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8F112EAD1
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Jan 2020 21:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725790AbgABUVc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Jan 2020 15:21:32 -0500
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:40856
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725783AbgABUVc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Jan 2020 15:21:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1577996490; bh=8Pa8JzhDwIeuuhGi2e65eO4/NkGl1rd0Ia1vDjx8ejA=; h=Subject:To:References:From:Cc:Date:In-Reply-To:From:Subject; b=nUyCIUHx0vxbznt38Uh53ByL6OCfk8/K0LHa8WQg64LsFIMY25XTxMx9AWuiEBcvTiJZ2grAUQTAGgePIdOlfPsFrb2CRsa2+qdSN4vmLMjmiFdvuCzX73IsU3ygrA6gc0/rTzZUvMNVUKWdaN2aIyJM1g2miM7E4JRSluenWdygNmTs7VP285onrTAz5BMp/9f28KVSrDNrO4UFOdfmuEOLh3f6wpcrDEfusuJupqo1bFaa/CjhIRa1EeYsEV1lcV5LOac0c10Yr4cGfqIGA3Ev6Bhw9Jygzcjjz9xj7zqSCyqsiq+dTWBNKiwtug24G270jBqQgm0X+zs/oWiAGw==
X-YMail-OSG: qAhumiUVM1m0KPJCQnv8qkU3sLHnP7ZB9g6PaH2BBZKkX0dAoICghIiPgXqUQ16
 4siYSeEe83qeKD_LZkyOOPbieOKiY52VhAqwOe2o18fzImKndVfUVKcipKXiJ.WiLE2mrSPWAZoo
 iPrlu0zv48ccT1dMjMoUzJUOLSlNtThJq3slOx9omI80tW10Hjl5ry3VxjclVPEk2uSKK7YpkcVn
 J08d3WJ8qFftfle51571hk_ZJAXfyn_9FyXxhS.XcwtddDoZX9aKQuywl42fmrV8VuyODzig4IWT
 e1R2cX2l7mLMpG0I9z3sh13JRxtcmKYqgJIpIxfIJidBmSaE15kahN1zLT3wo1VDGZsoVyRvJJSs
 5uPHdIegmqbWDtfXXTSNH1Vxsh2DPFU53wD2WjXe1ErfH.zokw2JZVimRd9USIft7vqAkbljXH4n
 Q5p7KBOefWLY8ZHDFS9Yy_kMrNLffS6fLo9xMe49AOmAjo1u0Xy7AMMSr5JhPBDOa015MU90z0vX
 Bt4yzXJYQnpuH8ngmLq1ODFGVtgtW.PFSrMbhiSNxtKd66Y69a0PXd37Nqvh_DeGDoDGd2IQj3.f
 eRqb8ulN_8Ok5oqx6IhTSoku5NfaPtQcWcFqBAKDyc1zXlKGJO7rWfuI3BZnyW1WGHOF_VHlf_Ys
 ZcJod7uanaK2l865DGh7Nccz5GhMG2gWvFuZjESavaNpHugsrWgux4hlbiNClwT304KpZadB6fxT
 g67mt7msN.y8UyO02acaHeaoLhf3s59tthlrUgs6zdKQhKSdQ5uOQvCfUlmw1vyYcHEOEKHzYsjL
 BK4eF2OGueZ3dx4bfpcz5ek1kPJA79heGf.4gltxFR9.R9KtE30myccTw.5f3ocXIrHJ7FRM46eo
 ORYlhjewoVNsF7.GBIc_2fU.4RgTWHxJ.Ca8yD7jh8GHWpekaOGWcnglxicwFsA_xC5Dx8eR3E1D
 FVieyb0mxzsbgCOAY3WMIiP0a18edkQtRJNvfnrZkAHbXbeIBQPY3oEN18.cFSR0IxkXniDulxI0
 eKP1HuCyQ6ptXSqm3hT54t2Qc9pfi.sFl_6dwFkC2x7B3m6npbRgyB1eZnNNB.sjL9B5_OHa_aYD
 MmMnXd_8SHsk4itrj2uhd4rxUze4oH5OQPpL6FzjHDC4RqCazaQHTUX8bQ30M3eBG0y0rnODG8oy
 R2FuCzlpxFeBcosqPyqTwtuCLFo5gQXmDG_PLmubFPVGjhotRAe8H5uHpTVwEbYGGzBKF6rwrAO4
 zA8cdbwtZZx_o.E_ftktHEQpK3UklTpGWjyrOLFxZi9OZJV8q5konQkaiqg2fSBXfLn4Wq0UiGy5
 x_aDuypMKohyYpw._YH_3arfBL5znx.iefSDcRHU_wRMFsPD6rHfQ2Yax_.gaf58lkBgdf4UGwVn
 gjmEhjXt3U4mdzZi.k8oIJVwbgo_7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Thu, 2 Jan 2020 20:21:30 +0000
Received: by smtp424.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 89a48dc815db215279e4460815f30004;
          Thu, 02 Jan 2020 20:21:26 +0000 (UTC)
Subject: Re: IMA's use of the audit rule code
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
References: <a6c15a35-a8cb-7589-7960-a19e788b6c45.ref@schaufler-ca.com>
 <a6c15a35-a8cb-7589-7960-a19e788b6c45@schaufler-ca.com>
 <1577992707.5874.110.camel@linux.ibm.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Cc:     Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <28459dc3-1b5e-b3e0-7139-2a5dcb46476b@schaufler-ca.com>
Date:   Thu, 2 Jan 2020 12:21:25 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <1577992707.5874.110.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.14873 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 1/2/2020 11:18 AM, Mimi Zohar wrote:
> On Thu, 2020-01-02 at 09:06 -0800, Casey Schaufler wrote:
>> IMA refines security_audit_rule_init to security_filter_rule_init.
>> I need to understand what, if any, relationship there is between
>> IMA's use of the audit rule mechanisms and the audit system's use.
>> Is this simple code reuse, or is there some interaction between IMA
>> and audit?
>>
>> I'm trying to sort out the problem of audit rules when
>> there are multiple security modules. It looks as if there is also a
>> problem for integrity rules, but it looks different. The "easy"
>> change for audit doesn't fit with what's in IMA. If there's no
>> interaction between the IMA and audit use of the rule infrastructure
>> it's reasonable to fix them separately. If there is interaction
>> things get messy.
> They're both comparing rules with LSM labels. =C2=A0In IMA's case, the =
LSM
> labels are used to identify which files are in/out of the IMA policy -
> "measurement", "appraisal", and "audit". =C2=A0I'm not sure how differe=
nt
> this is than the audit subsystem.

On a system that has both SELinux and Smack the audit admin might
want to set a rule on the label "system_u:object_r:something_t".
The LSM infrastructure can't tell if this is an SELinux label or a
Smack label, as it's valid for both. This is easily handled by
keeping an array of pointers for LSM checks, with a value set for
any module that wants to look for that label.
=20
IMA uses a very different data representation for its events than
audit does, making it much less obvious how to go about retaining
the security module to IMA event mapping. I'm looking at options.

>
> Mimi=C2=A0
>

