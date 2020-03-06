Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E35BD17C58B
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Mar 2020 19:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgCFSkS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 6 Mar 2020 13:40:18 -0500
Received: from mga04.intel.com ([192.55.52.120]:27043 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbgCFSkS (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 Mar 2020 13:40:18 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2020 10:40:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,523,1574150400"; 
   d="scan'208";a="264542722"
Received: from wbakowsk-mobl.ger.corp.intel.com (HELO localhost) ([10.252.27.142])
  by fmsmga004.fm.intel.com with ESMTP; 06 Mar 2020 10:40:13 -0800
Date:   Fri, 6 Mar 2020 20:40:13 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Waiman Long <longman@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Eric Biggers <ebiggers@google.com>,
        Chris von Recklinghausen <crecklin@redhat.com>
Subject: Re: [PATCH] KEYS: Don't write out to userspace while holding key
 semaphore
Message-ID: <20200306184013.GC7472@linux.intel.com>
References: <20200305210640.15315-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305210640.15315-1-longman@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Mar 05, 2020 at 04:06:40PM -0500, Waiman Long wrote:
> A lockdep circular locking dependency report was seen when running a
> keyutils test:
> 
> [12537.027242] ======================================================
> [12537.059309] WARNING: possible circular locking dependency detected
> [12537.088148] 4.18.0-147.7.1.el8_1.x86_64+debug #1 Tainted: G OE    --------- -  -
> [12537.125253] ------------------------------------------------------
> [12537.153189] keyctl/25598 is trying to acquire lock:
> [12537.175087] 000000007c39f96c (&mm->mmap_sem){++++}, at: __might_fault+0xc4/0x1b0
> [12537.208365]
> [12537.208365] but task is already holding lock:
> [12537.234507] 000000003de5b58d (&type->lock_class){++++}, at: keyctl_read_key+0x15a/0x220
> [12537.270476]
> [12537.270476] which lock already depends on the new lock.
> [12537.270476]
> [12537.307209]
> [12537.307209] the existing dependency chain (in reverse order) is:
> [12537.340754]
> [12537.340754] -> #3 (&type->lock_class){++++}:
> [12537.367434]        down_write+0x4d/0x110
> [12537.385202]        __key_link_begin+0x87/0x280
> [12537.405232]        request_key_and_link+0x483/0xf70
> [12537.427221]        request_key+0x3c/0x80
> [12537.444839]        dns_query+0x1db/0x5a5 [dns_resolver]
> [12537.468445]        dns_resolve_server_name_to_ip+0x1e1/0x4d0 [cifs]
> [12537.496731]        cifs_reconnect+0xe04/0x2500 [cifs]
> [12537.519418]        cifs_readv_from_socket+0x461/0x690 [cifs]
> [12537.546263]        cifs_read_from_socket+0xa0/0xe0 [cifs]
> [12537.573551]        cifs_demultiplex_thread+0x311/0x2db0 [cifs]
> [12537.601045]        kthread+0x30c/0x3d0
> [12537.617906]        ret_from_fork+0x3a/0x50
> [12537.636225]
> [12537.636225] -> #2 (root_key_user.cons_lock){+.+.}:
> [12537.664525]        __mutex_lock+0x105/0x11f0
> [12537.683734]        request_key_and_link+0x35a/0xf70
> [12537.705640]        request_key+0x3c/0x80
> [12537.723304]        dns_query+0x1db/0x5a5 [dns_resolver]
> [12537.746773]        dns_resolve_server_name_to_ip+0x1e1/0x4d0 [cifs]
> [12537.775607]        cifs_reconnect+0xe04/0x2500 [cifs]
> [12537.798322]        cifs_readv_from_socket+0x461/0x690 [cifs]
> [12537.823369]        cifs_read_from_socket+0xa0/0xe0 [cifs]
> [12537.847262]        cifs_demultiplex_thread+0x311/0x2db0 [cifs]
> [12537.873477]        kthread+0x30c/0x3d0
> [12537.890281]        ret_from_fork+0x3a/0x50
> [12537.908649]
> [12537.908649] -> #1 (&tcp_ses->srv_mutex){+.+.}:
> [12537.935225]        __mutex_lock+0x105/0x11f0
> [12537.954450]        cifs_call_async+0x102/0x7f0 [cifs]
> [12537.977250]        smb2_async_readv+0x6c3/0xc90 [cifs]
> [12538.000659]        cifs_readpages+0x120a/0x1e50 [cifs]
> [12538.023920]        read_pages+0xf5/0x560
> [12538.041583]        __do_page_cache_readahead+0x41d/0x4b0
> [12538.067047]        ondemand_readahead+0x44c/0xc10
> [12538.092069]        filemap_fault+0xec1/0x1830
> [12538.111637]        __do_fault+0x82/0x260
> [12538.129216]        do_fault+0x419/0xfb0
> [12538.146390]        __handle_mm_fault+0x862/0xdf0
> [12538.167408]        handle_mm_fault+0x154/0x550
> [12538.187401]        __do_page_fault+0x42f/0xa60
> [12538.207395]        do_page_fault+0x38/0x5e0
> [12538.225777]        page_fault+0x1e/0x30
> [12538.243010]
> [12538.243010] -> #0 (&mm->mmap_sem){++++}:
> [12538.267875]        lock_acquire+0x14c/0x420
> [12538.286848]        __might_fault+0x119/0x1b0
> [12538.306006]        keyring_read_iterator+0x7e/0x170
> [12538.327936]        assoc_array_subtree_iterate+0x97/0x280
> [12538.352154]        keyring_read+0xe9/0x110
> [12538.370558]        keyctl_read_key+0x1b9/0x220
> [12538.391470]        do_syscall_64+0xa5/0x4b0
> [12538.410511]        entry_SYSCALL_64_after_hwframe+0x6a/0xdf
> [12538.435535]
> [12538.435535] other info that might help us debug this:
> [12538.435535]
> [12538.472829] Chain exists of:
> [12538.472829]   &mm->mmap_sem --> root_key_user.cons_lock --> &type->lock_class
> [12538.472829]
> [12538.524820]  Possible unsafe locking scenario:
> [12538.524820]
> [12538.551431]        CPU0                    CPU1
> [12538.572654]        ----                    ----
> [12538.595865]   lock(&type->lock_class);
> [12538.613737]                                lock(root_key_user.cons_lock);
> [12538.644234]                                lock(&type->lock_class);
> [12538.672410]   lock(&mm->mmap_sem);
> [12538.687758]
> [12538.687758]  *** DEADLOCK ***
> [12538.687758]
> [12538.714455] 1 lock held by keyctl/25598:
> [12538.732097]  #0: 000000003de5b58d (&type->lock_class){++++}, at: keyctl_read_key+0x15a/0x220
> [12538.770573]
> [12538.770573] stack backtrace:
> [12538.790136] CPU: 2 PID: 25598 Comm: keyctl Kdump: loaded Tainted: G
> [12538.844855] Hardware name: HP ProLiant DL360 Gen9/ProLiant DL360 Gen9, BIOS P89 12/27/2015
> [12538.881963] Call Trace:
> [12538.892897]  dump_stack+0x9a/0xf0
> [12538.907908]  print_circular_bug.isra.25.cold.50+0x1bc/0x279
> [12538.932891]  ? save_trace+0xd6/0x250
> [12538.948979]  check_prev_add.constprop.32+0xc36/0x14f0
> [12538.971643]  ? keyring_compare_object+0x104/0x190
> [12538.992738]  ? check_usage+0x550/0x550
> [12539.009845]  ? sched_clock+0x5/0x10
> [12539.025484]  ? sched_clock_cpu+0x18/0x1e0
> [12539.043555]  __lock_acquire+0x1f12/0x38d0
> [12539.061551]  ? trace_hardirqs_on+0x10/0x10
> [12539.080554]  lock_acquire+0x14c/0x420
> [12539.100330]  ? __might_fault+0xc4/0x1b0
> [12539.119079]  __might_fault+0x119/0x1b0
> [12539.135869]  ? __might_fault+0xc4/0x1b0
> [12539.153234]  keyring_read_iterator+0x7e/0x170
> [12539.172787]  ? keyring_read+0x110/0x110
> [12539.190059]  assoc_array_subtree_iterate+0x97/0x280
> [12539.211526]  keyring_read+0xe9/0x110
> [12539.227561]  ? keyring_gc_check_iterator+0xc0/0xc0
> [12539.249076]  keyctl_read_key+0x1b9/0x220
> [12539.266660]  do_syscall_64+0xa5/0x4b0
> [12539.283091]  entry_SYSCALL_64_after_hwframe+0x6a/0xdf
> 
> One way to prevent this deadlock scenario from happening is to not
> allow writing to userspace while holding the key semaphore. Instead,
> an internal buffer is allocated for getting the keys out from the
> read method first before copying them out to userspace without holding
> the lock.
> 
> That requires taking out the __user modifier from the read methods as
> well as additional changes to not use any userspace write helpers.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Hi, quickly checked this (it is Friday night in Finland) and did not
see anything obvious that'd be wrong. I'll give a more detailed look
next week.

Thank you.

/Jarkko
