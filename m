Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C069010E44C
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Dec 2019 02:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfLBBph convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 1 Dec 2019 20:45:37 -0500
Received: from mga12.intel.com ([192.55.52.136]:45963 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727394AbfLBBph (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 1 Dec 2019 20:45:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Dec 2019 17:45:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,267,1571727600"; 
   d="scan'208";a="212870090"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga006.jf.intel.com with ESMTP; 01 Dec 2019 17:45:35 -0800
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 1 Dec 2019 17:45:34 -0800
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 1 Dec 2019 17:45:34 -0800
Received: from shsmsx104.ccr.corp.intel.com (10.239.4.70) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 1 Dec 2019 17:45:34 -0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.109]) by
 SHSMSX104.ccr.corp.intel.com ([169.254.5.90]) with mapi id 14.03.0439.000;
 Mon, 2 Dec 2019 09:45:31 +0800
From:   "Zhao, Shirley" <shirley.zhao@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>
CC:     James Bottomley <jejb@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'Mauro Carvalho Chehab'" <mchehab+samsung@kernel.org>,
        "Zhu, Bing" <bing.zhu@intel.com>,
        "Chen, Luhai" <luhai.chen@intel.com>
Subject: RE: One question about trusted key of keyring in Linux kernel.
Thread-Topic: One question about trusted key of keyring in Linux kernel.
Thread-Index: AdWZwFKzDBwFOydYTGGk+Aqs+6BIxAANhxEAAoxRZMAACTMHAACeWpwAAHsDLGA=
Date:   Mon, 2 Dec 2019 01:45:30 +0000
Message-ID: <A888B25CD99C1141B7C254171A953E8E4909CA4B@shsmsx102.ccr.corp.intel.com>
References: <A888B25CD99C1141B7C254171A953E8E49094313@shsmsx102.ccr.corp.intel.com>
 <1573659978.17949.83.camel@linux.ibm.com>
 <A888B25CD99C1141B7C254171A953E8E49095F9B@shsmsx102.ccr.corp.intel.com>
 <1574796456.4793.248.camel@linux.ibm.com>
 <20191129230146.GB15726@linux.intel.com>
In-Reply-To: <20191129230146.GB15726@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZGJjNWFmN2MtZWU2Ny00MGNmLTk2N2UtZWZiMTU0Mjk3OTNiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoidG1Nck1haHRoaDNJaEhmRlFFXC8zYVo4VHNHS1o2NmhKdU42UlBNdXBoM1o0Y2FrR1d5ck1VbDNOYTZaYU9WYVEifQ==
x-ctpclassification: CTP_NT
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi, Jarkko, 

The rc1 you mentioned is the version for what? 
How to download it and update it? 

Thanks. 

- Shirley 

-----Original Message-----
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> 
Sent: Saturday, November 30, 2019 7:02 AM
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Zhao, Shirley <shirley.zhao@intel.com>; James Bottomley <jejb@linux.ibm.com>; Jonathan Corbet <corbet@lwn.net>; linux-integrity@vger.kernel.org; keyrings@vger.kernel.org; linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org; 'Mauro Carvalho Chehab' <mchehab+samsung@kernel.org>; Zhu, Bing <bing.zhu@intel.com>; Chen, Luhai <luhai.chen@intel.com>
Subject: Re: One question about trusted key of keyring in Linux kernel.

On Tue, Nov 26, 2019 at 02:27:36PM -0500, Mimi Zohar wrote:
> On Tue, 2019-11-26 at 07:32 +0000, Zhao, Shirley wrote:
> > Thanks for your feedback, Mimi. 
> > But the document of dracut can't solve my problem. 
> > 
> > I did more test these days and try to descript my question in more detail. 
> > 
> > In my scenario, the trusted key will be sealed into TPM with PCR policy. 
> > And there are some related options in manual like 
> >        hash=         hash algorithm name as a string. For TPM 1.x the only
> >                      allowed value is sha1. For TPM 2.x the allowed values
> >                      are sha1, sha256, sha384, sha512 and sm3-256.
> >        policydigest= digest for the authorization policy. must be calculated
> >                      with the same hash algorithm as specified by the 'hash='
> >                      option.
> >        policyhandle= handle to an authorization policy session that defines the
> >                      same policy and with the same hash algorithm as was used to
> >                      seal the key. 
> > 
> > Here is my test step. 
> > Firstly, the pcr policy is generated as below: 
> > $ tpm2_createpolicy --policy-pcr --pcr-list sha256:7 --policy 
> > pcr7_bin.policy > pcr7.policy
> > 
> > Pcr7.policy is the ascii hex of policy:
> > $ cat pcr7.policy
> > 321fbd28b60fcc23017d501b133bd5dbf2889814588e8a23510fe10105cb2cc9
> > 
> > Then generate the trusted key and configure policydigest and get the key ID: 
> > $ keyctl add trusted kmk "new 32 keyhandle=0x81000001 hash=sha256 
> > policydigest=`cat pcr7.policy`" @u
> > 874117045
> > 
> > Save the trusted key. 
> > $ keyctl pipe 874117045 > kmk.blob
> > 
> > Reboot and load the key. 
> > Start a auth session to generate the policy:
> > $ tpm2_startauthsession -S session.ctx
> > session-handle: 0x3000000
> > $ tpm2_pcrlist -L sha256:7 -o pcr7.sha256 $ tpm2_policypcr -S 
> > session.ctx -L sha256:7 -F pcr7.sha256 -f pcr7.policy
> > policy-digest: 
> > 0x321FBD28B60FCC23017D501B133BD5DBF2889814588E8A23510FE10105CB2CC9
> > 
> > Input the policy handle to load trusted key:
> > $ keyctl add trusted kmk "load `cat kmk.blob` keyhandle=0x81000001 
> > policyhandle=0x3000000" @u
> > add_key: Operation not permitted
> > 
> > The error should be policy check failed, because I use TPM command to unseal directly with error of policy check failed. 
> > $ tpm2_unseal -c 0x81000001 -L sha256:7 ERROR on line: "81" in file: 
> > "./lib/log.h": Tss2_Sys_Unseal(0x99D) - tpm:session(1):a policy 
> > check failed ERROR on line: "213" in file: "tools/tpm2_unseal.c": Unseal failed!
> > ERROR on line: "166" in file: "tools/tpm2_tool.c": Unable to run 
> > tpm2_unseal
> > 
> > So my question is:
> > 1. How to use the option, policydigest, policyhandle?? Is there any example? 
> > 2. What's wrong with my test step? 
> 
> When reporting a problem please state which kernel is experiencing 
> this problem.  Recently there was a trusted key regression.  Refer to 
> commit e13cd21ffd50 "tpm: Wrap the buffer from the caller to tpm_buf 
> in tpm_send()" for the details.
> 
> Before delving into this particular problem, first please make sure 
> you are able to create, save, remove, and then reload a trusted key 
> not sealed to a PCR.

Please re-test with rc1 when available.

/Jarkko
