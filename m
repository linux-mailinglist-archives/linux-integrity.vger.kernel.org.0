Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE3E263DF
	for <lists+linux-integrity@lfdr.de>; Wed, 22 May 2019 14:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbfEVMav (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 May 2019 08:30:51 -0400
Received: from upbd19pa09.eemsg.mail.mil ([214.24.27.84]:8454 "EHLO
        UPBD19PA09.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728468AbfEVMav (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 May 2019 08:30:51 -0400
X-Greylist: delayed 633 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 May 2019 08:30:49 EDT
X-EEMSG-check-017: 196946110|UPBD19PA09_EEMSG_MP9.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPBD19PA09.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 22 May 2019 12:20:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1558527614; x=1590063614;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=JWfVGAf48Hd27kpbx/MMbpPaKmC6JJzWoZbPukUrP+k=;
  b=io4CFR9DL1suf71HVRZ0IfXkKtxhL7d8TkM4F2K7B7jSn97YHOLnwPnB
   OpJ4fUiwVYMu2VCNwvmLGLC4smAgNLYB4lupB80sDR8AEEVnrcI6LoV/c
   S+YoCHEZd3mqlo6GeUS5GfR2T1Q6BXDZlvZGUNJmyi0DFlxnoPL4azVsC
   Jd6PAR9fSm9sLMOWKK7XK+c7fL+3IaWf4EYwXfGMkrS58qEWiyOqYmPsQ
   2XGr9FlBC8sPo0MuUk93/TIoC2LvWGN2WTp/fLJsRE/ocj8RzPZWRUC6z
   45EV5HnTQhFZwuSGEqBw3RXeLL3jb3Oc+dNlGfxsktC8cRd5/XlBZo8gO
   w==;
X-IronPort-AV: E=Sophos;i="5.60,499,1549929600"; 
   d="scan'208";a="28027686"
IronPort-PHdr: =?us-ascii?q?9a23=3AzawwHxEkKHO8QpLGDLjkTJ1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ76psi9bnLW6fgltlLVR4KTs6sC17OP9fm5Aydcsd6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vMRm6txjdutQIjYdtJas8yQ?=
 =?us-ascii?q?bCr2dVdehR2W5mP0+YkQzm5se38p5j8iBQtOwk+sVdT6j0fLk2QKJBAjg+PG?=
 =?us-ascii?q?87+MPktR/YTQuS/XQcSXkZkgBJAwfe8h73WIr6vzbguep83CmaOtD2TawxVD?=
 =?us-ascii?q?+/4apnVAPkhSEaPDMi7mrZltJ/g75aoBK5phxw3YjUYJ2ONPFjeq/RZM4WSX?=
 =?us-ascii?q?ZdUspUUSFODJm8b48SBOQfO+hWoZT2q18XoRa+AQSgAeXiwSJKiHDrx603y/?=
 =?us-ascii?q?kvHx/I3AIgHNwAvnrbo9r3O6gOXu6417XIwDfZYv9KxTvw5orFfxY8qv+MR7?=
 =?us-ascii?q?Jwds/RxFEyGQPZkFqQsYzlMC2T1u8Qrmab6vBvVeari2E5qwB6vz+ixtwxhY?=
 =?us-ascii?q?nSnY8V1lDF+jl5wIYyP9G4TlV7bsS+HJtfsCGaKZJ7T8U/SG9roCY30qAKtJ?=
 =?us-ascii?q?G0cSQQyJkr2gTTZ+KIfoSW+B7vSeCcKipiin1/YrKwnROy/FClyu37S8a7zk?=
 =?us-ascii?q?5HrjFAktnQrnAN0AHT6tSfRvt94Eih3TGP2hjP6u5eO0A0lLfbK4U7zr4slp?=
 =?us-ascii?q?scrUTDHijslEXwkKCWbVkr9vKt6+TmZrXqvp6cN4lqhQHiKqkih8OyDOsiPg?=
 =?us-ascii?q?UOQmSX4/qw2bL98UHjXblGlvg2nbPYsJDeK8QbvKm5AwpN34Y49hm/FCyr0M?=
 =?us-ascii?q?gYnHYbLFJFfwiLj47yO17UOvz4AvC/g0q0nDdx2//GJqHhAonKLnXbkrfuZ7?=
 =?us-ascii?q?B960hCxwYpztBQ/YhUCrEcIPL1REDxssfVDhA8MwOuwubnDM9x2Z8ZWWKKGq?=
 =?us-ascii?q?WZKr/dsUeU5uIzJOmBfI4UuDH9K/c//f7jlns5mV4bfam00pobcnG4Ee9jI0?=
 =?us-ascii?q?mDfXXshdIBG38QvgUiVOzqlEGCUTlLanaqRa08+zU7BZm+DYjZW4CthKWN3C?=
 =?us-ascii?q?K8Hp1RfGBJFEqAHmvvd4WBQ/0Mcj6dItd9kjwYUrisU4sh1RCotA/nxLtrN+?=
 =?us-ascii?q?vU+isEtZ3929h1/ezTlQ0y9DFvEcSd3H+CT3tukmMLWTA2xqZ/rlJ5yluZ1q?=
 =?us-ascii?q?h4mfNYH8RJ5/xVSgc6KYLcz+tiBtD2WwLBeMqJSVm/TtW9Hz4+Us8xw8UPY0?=
 =?us-ascii?q?ZhG9SulxXD3y23DL8Ik7yEGoc58rzT33fvPcZx0XXG27c7j1kgXMRPMXeqhq?=
 =?us-ascii?q?ll9wjcVMb1lBC7nqCseOw/1TTN6WGOyyLavkheVgM2UqzfXW0Za03+otHw50?=
 =?us-ascii?q?eERLirX/BvFwpEyIawLatDcJW9n1JGTe3LPNXYfnL3mm21Qx2Pw+XIJJLjZm?=
 =?us-ascii?q?E1xCzADA0BlAcJ8DCNMg1tKD2mpjflEDF2FV/pK3jp+O16pWLzGlQ41CmWfk?=
 =?us-ascii?q?Zh0Pyz4RdTivuCHaBAlokYsTss/m0nVG222MjbXp/Z+lts?=
X-IPAS-Result: =?us-ascii?q?A2BGAACRPOVc/wHyM5BlHAEBAQQBAQcEAQGBUwUBAQsBg?=
 =?us-ascii?q?WYqgTsyhDuTXQaBNYlOiW+FGhSBZwkBAQEBAQEBAQE0AQIBAYRAAoIvIzYHD?=
 =?us-ascii?q?gEDAQEBBAEBAQEDAQFsKII6KQGCZwEFIxVBEAsYAgImAgJXBgEMCAEBgl8/g?=
 =?us-ascii?q?XcUp3+BL4VIgyaBRoEMKAGLUBd4gQeBOIJrPoQtgyGCWASTS5RmCYIPghGQb?=
 =?us-ascii?q?wYbgh6UFC2MMIEnlisBMYFXKwgCGAghD4MokGwjA4E2AQGNagEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 22 May 2019 12:20:12 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x4MCKBup016052;
        Wed, 22 May 2019 08:20:11 -0400
Subject: Re: sleep in selinux_audit_rule_init
To:     Janne Karhunen <janne.karhunen@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>, paul@paul-moore.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <CAE=NcrYsfQ2ijJJMEyTFoWnFqF2qGS=B2JNsVaE8WUNcGS7D9Q@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <e8dcc9a2-594d-f81a-32a7-e18f591c6062@tycho.nsa.gov>
Date:   Wed, 22 May 2019 08:20:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAE=NcrYsfQ2ijJJMEyTFoWnFqF2qGS=B2JNsVaE8WUNcGS7D9Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 5/22/19 7:49 AM, Janne Karhunen wrote:
> Hi,
> 
> I managed to hit a following BUG, looks like ima can call
> selinux_audit_rule_init that can sleep in rcu critical section in
> ima_match_policy():
> 
> __might_sleep
> kmem_cache_alloc_trace
> selinux_audit_rule_init <<< kzalloc (.. GFP_KERNEL)
> security_audit_rule_init
> ima_match_policy <<< list_for_each_entry_rcu
> ima_get_action
> process_measurement
> ima_file_check
> path_openat
> do_filp_open
> ..
> 
> I guess this is the ima_match_rules() calling ima_lsm_update_rules()
> when it concludes that the selinux policy may have been reloaded.
> 
> The easy way for me to fix my own butt in this regard is to change the
> selinux allocation not to wait, but Paul would you be OK with such
> change? The alternative looks like a pretty big change in the ima?

This is perhaps a sign of a deeper bug in IMA; if they are in the middle 
of matching against their policy rules, then they shouldn't be 
updating/modifying those rules in the middle of match processing?  How 
is that safe under RCU?

If you look at how the audit subsystem deals with the same problem, they 
have a callback (audit_update_lsm_rules) that is called upon an AVC 
reset (hence upon a policy reload) and can update all of their rules at 
that time, not lazily during matching.  Since that time, a more general 
notifier mechanism was added, register_lsm_notifier(), and is used by 
infiniband to update its state upon policy changes.



