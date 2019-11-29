Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40C2C10DB94
	for <lists+linux-integrity@lfdr.de>; Sat, 30 Nov 2019 00:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfK2XBy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 29 Nov 2019 18:01:54 -0500
Received: from mga05.intel.com ([192.55.52.43]:5392 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727073AbfK2XBy (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 Nov 2019 18:01:54 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Nov 2019 15:01:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,259,1571727600"; 
   d="scan'208";a="212413270"
Received: from gamanzi-mobl4.ger.corp.intel.com (HELO localhost) ([10.252.3.126])
  by orsmga006.jf.intel.com with ESMTP; 29 Nov 2019 15:01:48 -0800
Date:   Sat, 30 Nov 2019 01:01:46 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     "Zhao, Shirley" <shirley.zhao@intel.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        'Mauro Carvalho Chehab' <mchehab+samsung@kernel.org>,
        "Zhu, Bing" <bing.zhu@intel.com>,
        "Chen, Luhai" <luhai.chen@intel.com>
Subject: Re: One question about trusted key of keyring in Linux kernel.
Message-ID: <20191129230146.GB15726@linux.intel.com>
References: <A888B25CD99C1141B7C254171A953E8E49094313@shsmsx102.ccr.corp.intel.com>
 <1573659978.17949.83.camel@linux.ibm.com>
 <A888B25CD99C1141B7C254171A953E8E49095F9B@shsmsx102.ccr.corp.intel.com>
 <1574796456.4793.248.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1574796456.4793.248.camel@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

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
> > $ tpm2_createpolicy --policy-pcr --pcr-list sha256:7 --policy pcr7_bin.policy > pcr7.policy
> > 
> > Pcr7.policy is the ascii hex of policy:
> > $ cat pcr7.policy
> > 321fbd28b60fcc23017d501b133bd5dbf2889814588e8a23510fe10105cb2cc9
> > 
> > Then generate the trusted key and configure policydigest and get the key ID: 
> > $ keyctl add trusted kmk "new 32 keyhandle=0x81000001 hash=sha256 policydigest=`cat pcr7.policy`" @u
> > 874117045
> > 
> > Save the trusted key. 
> > $ keyctl pipe 874117045 > kmk.blob
> > 
> > Reboot and load the key. 
> > Start a auth session to generate the policy:
> > $ tpm2_startauthsession -S session.ctx
> > session-handle: 0x3000000
> > $ tpm2_pcrlist -L sha256:7 -o pcr7.sha256
> > $ tpm2_policypcr -S session.ctx -L sha256:7 -F pcr7.sha256 -f pcr7.policy
> > policy-digest: 0x321FBD28B60FCC23017D501B133BD5DBF2889814588E8A23510FE10105CB2CC9
> > 
> > Input the policy handle to load trusted key:
> > $ keyctl add trusted kmk "load `cat kmk.blob` keyhandle=0x81000001 policyhandle=0x3000000" @u
> > add_key: Operation not permitted
> > 
> > The error should be policy check failed, because I use TPM command to unseal directly with error of policy check failed. 
> > $ tpm2_unseal -c 0x81000001 -L sha256:7
> > ERROR on line: "81" in file: "./lib/log.h": Tss2_Sys_Unseal(0x99D) - tpm:session(1):a policy check failed
> > ERROR on line: "213" in file: "tools/tpm2_unseal.c": Unseal failed!
> > ERROR on line: "166" in file: "tools/tpm2_tool.c": Unable to run tpm2_unseal
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
