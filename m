Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 893C92640C
	for <lists+linux-integrity@lfdr.de>; Wed, 22 May 2019 14:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbfEVMvR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 May 2019 08:51:17 -0400
Received: from uhil19pa09.eemsg.mail.mil ([214.24.21.82]:61933 "EHLO
        uhil19pa09.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728794AbfEVMvR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 May 2019 08:51:17 -0400
X-Greylist: delayed 580 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 May 2019 08:51:16 EDT
X-EEMSG-check-017: 19073167|UHIL19PA09_EEMSG_MP7.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by uhil19pa09.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 22 May 2019 12:41:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1558528894; x=1590064894;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=3fj+Q3aA8pKYLM2VOnl3O56mpCOnBhYKCIIGAcmYWWE=;
  b=IBloO0mjY4D63P4gu8bettN9dtBqt6mRQJrZ81Sgfz398vd38hZCOwc1
   YTsIDHuLI91EtVebUb0UbeZ04kgOYgF1wusqWokMwI5gUrUm834gxhfNT
   ijq1ihSfavlzu/oX3eO/ovTO4CodA6cOq2nP1vKiBvTdSNsWT23ZOAjw3
   n8YL4bIgcNi3BD0jemHq5uDSMeI8ALky5AFwSQuWb0+VK3UMl0e/NRhXR
   AxzPqL4YqJ5F1U5/XgY7iT2ZXKkaoHRJ399fbVhExU9C53+sfoJ32U/Z5
   J7fyADnjp2BTOhlCbT2B/erc98yZUwHziqsJB6vRULEQNfKiTMpCE59kB
   g==;
X-IronPort-AV: E=Sophos;i="5.60,499,1549929600"; 
   d="scan'208";a="23972226"
IronPort-PHdr: =?us-ascii?q?9a23=3AABr/bxT9gs4Cyh7LSZDCPYpuJ9psv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa67ZRCAt8tkgFKBZ4jH8fUM07OQ7/m5HzVZu93c6zgrS99lb1?=
 =?us-ascii?q?c9k8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUh?=
 =?us-ascii?q?rwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmrsAndrNQajZZ8Jqo+yh?=
 =?us-ascii?q?bErGZDdvhLy29vOV+dhQv36N2q/J5k/SRQuvYh+NBFXK7nYak2TqFWASo/PW?=
 =?us-ascii?q?wt68LlqRfMTQ2U5nsBSWoWiQZHAxLE7B7hQJj8tDbxu/dn1ymbOc32Sq00WS?=
 =?us-ascii?q?in4qx2RhLklDsLOjgk+2zMlMd+kLxUrw6gpxxnwo7bfoeVNOZlfqjAed8WXH?=
 =?us-ascii?q?dNUtpNWyBEBI6zYZEPD+4cNuhGqYfzqUYFoR+nCQSsAO7jzzlFjWL006Inye?=
 =?us-ascii?q?QsCRzI0gw+EdIAs3raotv6O6gQXu+pw6fF1inDYvBM1Dvh9ITFfBIsrPeRVr?=
 =?us-ascii?q?xwa8rRzkwvGhvYgFWMt4PlJzOV2foLs2OG8uRgUPigi2ojqw5vojmk28Ahip?=
 =?us-ascii?q?LUiYIO0V3E6SV4z5o1Jd2/UkJ7Z8WkH4FKuyGVMIt2XNovTmd1syg50r0LoY?=
 =?us-ascii?q?O3cScFxZg9xxPTduaLf5aH7x79TuqdPDF1j29/dr2lnRa9602gx/X5VsmzzV?=
 =?us-ascii?q?lFsDJIksLJtnARzxzT7dWHSudl8kehxzmP0wfT5/lYIU8uj6rbKoMhwqUqmp?=
 =?us-ascii?q?oPsUXMAi/2mELsgK+Qakok4fSn5/7iYrXnop+QL450igfgPaQygsGzHOs1Pw?=
 =?us-ascii?q?cUU2Wb5OiwzqPv8ELnTLlQk/E6iqzZv4rbJcQfqK65GQhV0oM75hakEjimy8?=
 =?us-ascii?q?8VnWUHLV1ZeBKHiJLlO1fVIP/iF/u/jFOskClzy/DcIrLhGonNLmTEkLr5f7?=
 =?us-ascii?q?Zy8UhcyAwtwtxF5JJbEKsBIPLuWk/3qtPYCAQ0MwOxw+n9CdV90pkSVn6IAq?=
 =?us-ascii?q?+cKKnSq0OH5vozI+mQY48YoDf8K/8l5/H0l380glsdfaiv3ZsKZ3G0BPVmLF?=
 =?us-ascii?q?6cYXb2ntgBFmIKtBIkTOP2kF2CTSJTZ3GqUqIk/D47FYamAJzbRo+3nbyB2D?=
 =?us-ascii?q?63HphRZmBBEFCDD23keJmDW/cJcCiSONNukiQYVbi9TI8szRWutA78y7p6Ie?=
 =?us-ascii?q?vY4ywYtZT/1Ndr6O3TjxAy9SB0DsmGzWGNQH97nnkSSz81wq9/u0p9xUmH0a?=
 =?us-ascii?q?RihPxYD9NT7etTUggmLZ7c0/B6C9fqVwLFf9eJTkumQ9q/DTEqUN0+38IOY1?=
 =?us-ascii?q?x8G9W+jhHPxi+qA7gImLyWAJw77LnR32b+J8lj0XbKzqohgEc8QstJK2Kmgr?=
 =?us-ascii?q?Rz9w/JB47GwA2lkPOIfKIa0Wbu/X2D0GyDugkMUgd2V6iDXnkFZlbQoNLR6U?=
 =?us-ascii?q?bLTrvoArMiZE8J7M+HK+N4bd3glx0SVvDjMc72Z2O3hnf2BByNgLiLadyuM3?=
 =?us-ascii?q?0UwSH1EEEZl0UW+nGcOE41ASLyjXjZCWlVCV/3Y07qudJ7oXe/Q158mxqGdG?=
 =?us-ascii?q?V9xrG1/VgTnvXaRPQNiOFX8Bw9oil5SQ7ul+ndDMCN8k84IfRR?=
X-IPAS-Result: =?us-ascii?q?A2CJAgCoQuVc/wHyM5BlHAEBAQQBAQcEAQGBZYFnKoE7M?=
 =?us-ascii?q?oQ7k10GgRAliU6Jb4UugWcJAQEBAQEBAQEBNAECAQGEQAKCMSM4EwEDAQEBB?=
 =?us-ascii?q?AEBAQEDAQFsKII6KQGCZwEFIw8BBUEQCxgCAiYCAlcGAQwIAQGCXz+BdxSne?=
 =?us-ascii?q?oEviG6BRoEMKItRF3iBB4E4DIJfPoQsAYMhglgEmmCNUQmCD4IRkG8GG4Iej?=
 =?us-ascii?q?ESHUC2MMIEnljwhgVcrCAIYCCEPgyiQbCMDgTYBAY1qAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 22 May 2019 12:41:33 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x4MCfXQh022497;
        Wed, 22 May 2019 08:41:33 -0400
Subject: Re: sleep in selinux_audit_rule_init
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Janne Karhunen <janne.karhunen@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>, paul@paul-moore.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <CAE=NcrYsfQ2ijJJMEyTFoWnFqF2qGS=B2JNsVaE8WUNcGS7D9Q@mail.gmail.com>
 <e8dcc9a2-594d-f81a-32a7-e18f591c6062@tycho.nsa.gov>
Message-ID: <4a725f06-8244-8264-a911-df7ca1c66789@tycho.nsa.gov>
Date:   Wed, 22 May 2019 08:41:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e8dcc9a2-594d-f81a-32a7-e18f591c6062@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 5/22/19 8:20 AM, Stephen Smalley wrote:
> On 5/22/19 7:49 AM, Janne Karhunen wrote:
>> Hi,
>>
>> I managed to hit a following BUG, looks like ima can call
>> selinux_audit_rule_init that can sleep in rcu critical section in
>> ima_match_policy():
>>
>> __might_sleep
>> kmem_cache_alloc_trace
>> selinux_audit_rule_init <<< kzalloc (.. GFP_KERNEL)
>> security_audit_rule_init
>> ima_match_policy <<< list_for_each_entry_rcu
>> ima_get_action
>> process_measurement
>> ima_file_check
>> path_openat
>> do_filp_open
>> ..
>>
>> I guess this is the ima_match_rules() calling ima_lsm_update_rules()
>> when it concludes that the selinux policy may have been reloaded.
>>
>> The easy way for me to fix my own butt in this regard is to change the
>> selinux allocation not to wait, but Paul would you be OK with such
>> change? The alternative looks like a pretty big change in the ima?
> 
> This is perhaps a sign of a deeper bug in IMA; if they are in the middle 
> of matching against their policy rules, then they shouldn't be 
> updating/modifying those rules in the middle of match processing?  How 
> is that safe under RCU?
> 
> If you look at how the audit subsystem deals with the same problem, they 
> have a callback (audit_update_lsm_rules) that is called upon an AVC 
> reset (hence upon a policy reload) and can update all of their rules at 
> that time, not lazily during matching.  Since that time, a more general 
> notifier mechanism was added, register_lsm_notifier(), and is used by 
> infiniband to update its state upon policy changes.

Another potentially worrisome aspect of the current 
ima_lsm_update_rules() logic is that it does a BUG_ON() if the attempt 
to update the rule fails, which could occur if e.g. one had an IMA 
policy rule based on a given domain/type and that domain/type were 
removed from policy (e.g. via policy module removal).  Contrast with the 
handling in audit_dupe_lsm_field().  The existing ima_lsm_update_rules() 
logic could also yield a BUG_ON upon transient memory allocation failure.
