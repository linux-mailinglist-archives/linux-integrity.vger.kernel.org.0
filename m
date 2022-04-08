Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B511D4F8E8C
	for <lists+linux-integrity@lfdr.de>; Fri,  8 Apr 2022 08:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235028AbiDHFsd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 8 Apr 2022 01:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234998AbiDHFsb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 Apr 2022 01:48:31 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640F819BE7B;
        Thu,  7 Apr 2022 22:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649396786; x=1680932786;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Vf1SoRzAE5S7DLSZ163Os6ifvTrA0HoP88KmK/mnHXU=;
  b=Qb24S0v/XYwTCgeLkj2LZBmVnNEQkg8x0HiT0iDp6Cybs/bka/eXucnx
   ser121PcVBQ+MzO/jD1l1pRjkD89CRIB9o7axqJYMOQoCc4b2UJlfZdvc
   N6dc2xHGXYkc8gnOcUOpujNSb09a3J2T3f5xiPE6YhSmEJjtVXXPh1gqx
   2zOWSAnLUTv01I08P8/XBp9cCgJ9bCVXsxnsiWahQFrwE3+xH66XgwFJe
   4sOQpSLSfY4NWYd2TZx54exOABx0lnNAuxFCW0xBeYCHuEhAxgnpEQEfC
   rcGzdP2mh4xxJ0f8/BvFxQaZLeOG1aDpJ4GyG2LkRwHLFN7jE6BNQVvYt
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="243648480"
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; 
   d="scan'208";a="243648480"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 22:46:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; 
   d="scan'208";a="698065369"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 07 Apr 2022 22:46:22 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nchRt-00066F-JT;
        Fri, 08 Apr 2022 05:46:21 +0000
Date:   Fri, 8 Apr 2022 13:46:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     kbuild-all@lists.01.org, casey@schaufler-ca.com,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v34 13/29] LSM: Use lsmblob in security_cred_getsecid
Message-ID: <202204081320.5x10QzQZ-lkp@intel.com>
References: <20220407212230.12893-14-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407212230.12893-14-casey@schaufler-ca.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Casey,

I love your patch! Yet something to improve:

[auto build test ERROR on pcmoore-selinux/next]
[also build test ERROR on linus/master v5.18-rc1 next-20220407]
[cannot apply to pcmoore-audit/next jmorris-security/next-testing]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Casey-Schaufler/integrity-disassociate-ima_filter_rule-from-security_audit_rule/20220408-062243
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git next
config: s390-randconfig-r002-20220407 (https://download.01.org/0day-ci/archive/20220408/202204081320.5x10QzQZ-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/bc9f0527e49aae03063d9cb0d32345e53d2e2ad3
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Casey-Schaufler/integrity-disassociate-ima_filter_rule-from-security_audit_rule/20220408-062243
        git checkout bc9f0527e49aae03063d9cb0d32345e53d2e2ad3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/android/binder.c: In function 'binder_transaction':
>> drivers/android/binder.c:2986:52: error: passing argument 2 of 'security_cred_getsecid' from incompatible pointer type [-Werror=incompatible-pointer-types]
    2986 |                 security_cred_getsecid(proc->cred, &blob);
         |                                                    ^~~~~
         |                                                    |
         |                                                    struct lsmblob *
   In file included from drivers/android/binder.c:63:
   include/linux/security.h:1126:70: note: expected 'u32 *' {aka 'unsigned int *'} but argument is of type 'struct lsmblob *'
    1126 | static inline void security_cred_getsecid(const struct cred *c, u32 *secid)
         |                                                                 ~~~~~^~~~~
   cc1: some warnings being treated as errors


vim +/security_cred_getsecid +2986 drivers/android/binder.c

  2699	
  2700	static void binder_transaction(struct binder_proc *proc,
  2701				       struct binder_thread *thread,
  2702				       struct binder_transaction_data *tr, int reply,
  2703				       binder_size_t extra_buffers_size)
  2704	{
  2705		int ret;
  2706		struct binder_transaction *t;
  2707		struct binder_work *w;
  2708		struct binder_work *tcomplete;
  2709		binder_size_t buffer_offset = 0;
  2710		binder_size_t off_start_offset, off_end_offset;
  2711		binder_size_t off_min;
  2712		binder_size_t sg_buf_offset, sg_buf_end_offset;
  2713		binder_size_t user_offset = 0;
  2714		struct binder_proc *target_proc = NULL;
  2715		struct binder_thread *target_thread = NULL;
  2716		struct binder_node *target_node = NULL;
  2717		struct binder_transaction *in_reply_to = NULL;
  2718		struct binder_transaction_log_entry *e;
  2719		uint32_t return_error = 0;
  2720		uint32_t return_error_param = 0;
  2721		uint32_t return_error_line = 0;
  2722		binder_size_t last_fixup_obj_off = 0;
  2723		binder_size_t last_fixup_min_off = 0;
  2724		struct binder_context *context = proc->context;
  2725		int t_debug_id = atomic_inc_return(&binder_last_id);
  2726		char *secctx = NULL;
  2727		u32 secctx_sz = 0;
  2728		struct list_head sgc_head;
  2729		struct list_head pf_head;
  2730		const void __user *user_buffer = (const void __user *)
  2731					(uintptr_t)tr->data.ptr.buffer;
  2732		INIT_LIST_HEAD(&sgc_head);
  2733		INIT_LIST_HEAD(&pf_head);
  2734	
  2735		e = binder_transaction_log_add(&binder_transaction_log);
  2736		e->debug_id = t_debug_id;
  2737		e->call_type = reply ? 2 : !!(tr->flags & TF_ONE_WAY);
  2738		e->from_proc = proc->pid;
  2739		e->from_thread = thread->pid;
  2740		e->target_handle = tr->target.handle;
  2741		e->data_size = tr->data_size;
  2742		e->offsets_size = tr->offsets_size;
  2743		strscpy(e->context_name, proc->context->name, BINDERFS_MAX_NAME);
  2744	
  2745		if (reply) {
  2746			binder_inner_proc_lock(proc);
  2747			in_reply_to = thread->transaction_stack;
  2748			if (in_reply_to == NULL) {
  2749				binder_inner_proc_unlock(proc);
  2750				binder_user_error("%d:%d got reply transaction with no transaction stack\n",
  2751						  proc->pid, thread->pid);
  2752				return_error = BR_FAILED_REPLY;
  2753				return_error_param = -EPROTO;
  2754				return_error_line = __LINE__;
  2755				goto err_empty_call_stack;
  2756			}
  2757			if (in_reply_to->to_thread != thread) {
  2758				spin_lock(&in_reply_to->lock);
  2759				binder_user_error("%d:%d got reply transaction with bad transaction stack, transaction %d has target %d:%d\n",
  2760					proc->pid, thread->pid, in_reply_to->debug_id,
  2761					in_reply_to->to_proc ?
  2762					in_reply_to->to_proc->pid : 0,
  2763					in_reply_to->to_thread ?
  2764					in_reply_to->to_thread->pid : 0);
  2765				spin_unlock(&in_reply_to->lock);
  2766				binder_inner_proc_unlock(proc);
  2767				return_error = BR_FAILED_REPLY;
  2768				return_error_param = -EPROTO;
  2769				return_error_line = __LINE__;
  2770				in_reply_to = NULL;
  2771				goto err_bad_call_stack;
  2772			}
  2773			thread->transaction_stack = in_reply_to->to_parent;
  2774			binder_inner_proc_unlock(proc);
  2775			binder_set_nice(in_reply_to->saved_priority);
  2776			target_thread = binder_get_txn_from_and_acq_inner(in_reply_to);
  2777			if (target_thread == NULL) {
  2778				/* annotation for sparse */
  2779				__release(&target_thread->proc->inner_lock);
  2780				return_error = BR_DEAD_REPLY;
  2781				return_error_line = __LINE__;
  2782				goto err_dead_binder;
  2783			}
  2784			if (target_thread->transaction_stack != in_reply_to) {
  2785				binder_user_error("%d:%d got reply transaction with bad target transaction stack %d, expected %d\n",
  2786					proc->pid, thread->pid,
  2787					target_thread->transaction_stack ?
  2788					target_thread->transaction_stack->debug_id : 0,
  2789					in_reply_to->debug_id);
  2790				binder_inner_proc_unlock(target_thread->proc);
  2791				return_error = BR_FAILED_REPLY;
  2792				return_error_param = -EPROTO;
  2793				return_error_line = __LINE__;
  2794				in_reply_to = NULL;
  2795				target_thread = NULL;
  2796				goto err_dead_binder;
  2797			}
  2798			target_proc = target_thread->proc;
  2799			target_proc->tmp_ref++;
  2800			binder_inner_proc_unlock(target_thread->proc);
  2801		} else {
  2802			if (tr->target.handle) {
  2803				struct binder_ref *ref;
  2804	
  2805				/*
  2806				 * There must already be a strong ref
  2807				 * on this node. If so, do a strong
  2808				 * increment on the node to ensure it
  2809				 * stays alive until the transaction is
  2810				 * done.
  2811				 */
  2812				binder_proc_lock(proc);
  2813				ref = binder_get_ref_olocked(proc, tr->target.handle,
  2814							     true);
  2815				if (ref) {
  2816					target_node = binder_get_node_refs_for_txn(
  2817							ref->node, &target_proc,
  2818							&return_error);
  2819				} else {
  2820					binder_user_error("%d:%d got transaction to invalid handle, %u\n",
  2821							  proc->pid, thread->pid, tr->target.handle);
  2822					return_error = BR_FAILED_REPLY;
  2823				}
  2824				binder_proc_unlock(proc);
  2825			} else {
  2826				mutex_lock(&context->context_mgr_node_lock);
  2827				target_node = context->binder_context_mgr_node;
  2828				if (target_node)
  2829					target_node = binder_get_node_refs_for_txn(
  2830							target_node, &target_proc,
  2831							&return_error);
  2832				else
  2833					return_error = BR_DEAD_REPLY;
  2834				mutex_unlock(&context->context_mgr_node_lock);
  2835				if (target_node && target_proc->pid == proc->pid) {
  2836					binder_user_error("%d:%d got transaction to context manager from process owning it\n",
  2837							  proc->pid, thread->pid);
  2838					return_error = BR_FAILED_REPLY;
  2839					return_error_param = -EINVAL;
  2840					return_error_line = __LINE__;
  2841					goto err_invalid_target_handle;
  2842				}
  2843			}
  2844			if (!target_node) {
  2845				/*
  2846				 * return_error is set above
  2847				 */
  2848				return_error_param = -EINVAL;
  2849				return_error_line = __LINE__;
  2850				goto err_dead_binder;
  2851			}
  2852			e->to_node = target_node->debug_id;
  2853			if (WARN_ON(proc == target_proc)) {
  2854				return_error = BR_FAILED_REPLY;
  2855				return_error_param = -EINVAL;
  2856				return_error_line = __LINE__;
  2857				goto err_invalid_target_handle;
  2858			}
  2859			if (security_binder_transaction(proc->cred,
  2860							target_proc->cred) < 0) {
  2861				return_error = BR_FAILED_REPLY;
  2862				return_error_param = -EPERM;
  2863				return_error_line = __LINE__;
  2864				goto err_invalid_target_handle;
  2865			}
  2866			binder_inner_proc_lock(proc);
  2867	
  2868			w = list_first_entry_or_null(&thread->todo,
  2869						     struct binder_work, entry);
  2870			if (!(tr->flags & TF_ONE_WAY) && w &&
  2871			    w->type == BINDER_WORK_TRANSACTION) {
  2872				/*
  2873				 * Do not allow new outgoing transaction from a
  2874				 * thread that has a transaction at the head of
  2875				 * its todo list. Only need to check the head
  2876				 * because binder_select_thread_ilocked picks a
  2877				 * thread from proc->waiting_threads to enqueue
  2878				 * the transaction, and nothing is queued to the
  2879				 * todo list while the thread is on waiting_threads.
  2880				 */
  2881				binder_user_error("%d:%d new transaction not allowed when there is a transaction on thread todo\n",
  2882						  proc->pid, thread->pid);
  2883				binder_inner_proc_unlock(proc);
  2884				return_error = BR_FAILED_REPLY;
  2885				return_error_param = -EPROTO;
  2886				return_error_line = __LINE__;
  2887				goto err_bad_todo_list;
  2888			}
  2889	
  2890			if (!(tr->flags & TF_ONE_WAY) && thread->transaction_stack) {
  2891				struct binder_transaction *tmp;
  2892	
  2893				tmp = thread->transaction_stack;
  2894				if (tmp->to_thread != thread) {
  2895					spin_lock(&tmp->lock);
  2896					binder_user_error("%d:%d got new transaction with bad transaction stack, transaction %d has target %d:%d\n",
  2897						proc->pid, thread->pid, tmp->debug_id,
  2898						tmp->to_proc ? tmp->to_proc->pid : 0,
  2899						tmp->to_thread ?
  2900						tmp->to_thread->pid : 0);
  2901					spin_unlock(&tmp->lock);
  2902					binder_inner_proc_unlock(proc);
  2903					return_error = BR_FAILED_REPLY;
  2904					return_error_param = -EPROTO;
  2905					return_error_line = __LINE__;
  2906					goto err_bad_call_stack;
  2907				}
  2908				while (tmp) {
  2909					struct binder_thread *from;
  2910	
  2911					spin_lock(&tmp->lock);
  2912					from = tmp->from;
  2913					if (from && from->proc == target_proc) {
  2914						atomic_inc(&from->tmp_ref);
  2915						target_thread = from;
  2916						spin_unlock(&tmp->lock);
  2917						break;
  2918					}
  2919					spin_unlock(&tmp->lock);
  2920					tmp = tmp->from_parent;
  2921				}
  2922			}
  2923			binder_inner_proc_unlock(proc);
  2924		}
  2925		if (target_thread)
  2926			e->to_thread = target_thread->pid;
  2927		e->to_proc = target_proc->pid;
  2928	
  2929		/* TODO: reuse incoming transaction for reply */
  2930		t = kzalloc(sizeof(*t), GFP_KERNEL);
  2931		if (t == NULL) {
  2932			return_error = BR_FAILED_REPLY;
  2933			return_error_param = -ENOMEM;
  2934			return_error_line = __LINE__;
  2935			goto err_alloc_t_failed;
  2936		}
  2937		INIT_LIST_HEAD(&t->fd_fixups);
  2938		binder_stats_created(BINDER_STAT_TRANSACTION);
  2939		spin_lock_init(&t->lock);
  2940	
  2941		tcomplete = kzalloc(sizeof(*tcomplete), GFP_KERNEL);
  2942		if (tcomplete == NULL) {
  2943			return_error = BR_FAILED_REPLY;
  2944			return_error_param = -ENOMEM;
  2945			return_error_line = __LINE__;
  2946			goto err_alloc_tcomplete_failed;
  2947		}
  2948		binder_stats_created(BINDER_STAT_TRANSACTION_COMPLETE);
  2949	
  2950		t->debug_id = t_debug_id;
  2951	
  2952		if (reply)
  2953			binder_debug(BINDER_DEBUG_TRANSACTION,
  2954				     "%d:%d BC_REPLY %d -> %d:%d, data %016llx-%016llx size %lld-%lld-%lld\n",
  2955				     proc->pid, thread->pid, t->debug_id,
  2956				     target_proc->pid, target_thread->pid,
  2957				     (u64)tr->data.ptr.buffer,
  2958				     (u64)tr->data.ptr.offsets,
  2959				     (u64)tr->data_size, (u64)tr->offsets_size,
  2960				     (u64)extra_buffers_size);
  2961		else
  2962			binder_debug(BINDER_DEBUG_TRANSACTION,
  2963				     "%d:%d BC_TRANSACTION %d -> %d - node %d, data %016llx-%016llx size %lld-%lld-%lld\n",
  2964				     proc->pid, thread->pid, t->debug_id,
  2965				     target_proc->pid, target_node->debug_id,
  2966				     (u64)tr->data.ptr.buffer,
  2967				     (u64)tr->data.ptr.offsets,
  2968				     (u64)tr->data_size, (u64)tr->offsets_size,
  2969				     (u64)extra_buffers_size);
  2970	
  2971		if (!reply && !(tr->flags & TF_ONE_WAY))
  2972			t->from = thread;
  2973		else
  2974			t->from = NULL;
  2975		t->sender_euid = task_euid(proc->tsk);
  2976		t->to_proc = target_proc;
  2977		t->to_thread = target_thread;
  2978		t->code = tr->code;
  2979		t->flags = tr->flags;
  2980		t->priority = task_nice(current);
  2981	
  2982		if (target_node && target_node->txn_security_ctx) {
  2983			struct lsmblob blob;
  2984			size_t added_size;
  2985	
> 2986			security_cred_getsecid(proc->cred, &blob);
  2987			ret = security_secid_to_secctx(&blob, &secctx, &secctx_sz);
  2988			if (ret) {
  2989				return_error = BR_FAILED_REPLY;
  2990				return_error_param = ret;
  2991				return_error_line = __LINE__;
  2992				goto err_get_secctx_failed;
  2993			}
  2994			added_size = ALIGN(secctx_sz, sizeof(u64));
  2995			extra_buffers_size += added_size;
  2996			if (extra_buffers_size < added_size) {
  2997				/* integer overflow of extra_buffers_size */
  2998				return_error = BR_FAILED_REPLY;
  2999				return_error_param = -EINVAL;
  3000				return_error_line = __LINE__;
  3001				goto err_bad_extra_size;
  3002			}
  3003		}
  3004	
  3005		trace_binder_transaction(reply, t, target_node);
  3006	
  3007		t->buffer = binder_alloc_new_buf(&target_proc->alloc, tr->data_size,
  3008			tr->offsets_size, extra_buffers_size,
  3009			!reply && (t->flags & TF_ONE_WAY), current->tgid);
  3010		if (IS_ERR(t->buffer)) {
  3011			/*
  3012			 * -ESRCH indicates VMA cleared. The target is dying.
  3013			 */
  3014			return_error_param = PTR_ERR(t->buffer);
  3015			return_error = return_error_param == -ESRCH ?
  3016				BR_DEAD_REPLY : BR_FAILED_REPLY;
  3017			return_error_line = __LINE__;
  3018			t->buffer = NULL;
  3019			goto err_binder_alloc_buf_failed;
  3020		}
  3021		if (secctx) {
  3022			int err;
  3023			size_t buf_offset = ALIGN(tr->data_size, sizeof(void *)) +
  3024					    ALIGN(tr->offsets_size, sizeof(void *)) +
  3025					    ALIGN(extra_buffers_size, sizeof(void *)) -
  3026					    ALIGN(secctx_sz, sizeof(u64));
  3027	
  3028			t->security_ctx = (uintptr_t)t->buffer->user_data + buf_offset;
  3029			err = binder_alloc_copy_to_buffer(&target_proc->alloc,
  3030							  t->buffer, buf_offset,
  3031							  secctx, secctx_sz);
  3032			if (err) {
  3033				t->security_ctx = 0;
  3034				WARN_ON(1);
  3035			}
  3036			security_release_secctx(secctx, secctx_sz);
  3037			secctx = NULL;
  3038		}
  3039		t->buffer->debug_id = t->debug_id;
  3040		t->buffer->transaction = t;
  3041		t->buffer->target_node = target_node;
  3042		t->buffer->clear_on_free = !!(t->flags & TF_CLEAR_BUF);
  3043		trace_binder_transaction_alloc_buf(t->buffer);
  3044	
  3045		if (binder_alloc_copy_user_to_buffer(
  3046					&target_proc->alloc,
  3047					t->buffer,
  3048					ALIGN(tr->data_size, sizeof(void *)),
  3049					(const void __user *)
  3050						(uintptr_t)tr->data.ptr.offsets,
  3051					tr->offsets_size)) {
  3052			binder_user_error("%d:%d got transaction with invalid offsets ptr\n",
  3053					proc->pid, thread->pid);
  3054			return_error = BR_FAILED_REPLY;
  3055			return_error_param = -EFAULT;
  3056			return_error_line = __LINE__;
  3057			goto err_copy_data_failed;
  3058		}
  3059		if (!IS_ALIGNED(tr->offsets_size, sizeof(binder_size_t))) {
  3060			binder_user_error("%d:%d got transaction with invalid offsets size, %lld\n",
  3061					proc->pid, thread->pid, (u64)tr->offsets_size);
  3062			return_error = BR_FAILED_REPLY;
  3063			return_error_param = -EINVAL;
  3064			return_error_line = __LINE__;
  3065			goto err_bad_offset;
  3066		}
  3067		if (!IS_ALIGNED(extra_buffers_size, sizeof(u64))) {
  3068			binder_user_error("%d:%d got transaction with unaligned buffers size, %lld\n",
  3069					  proc->pid, thread->pid,
  3070					  (u64)extra_buffers_size);
  3071			return_error = BR_FAILED_REPLY;
  3072			return_error_param = -EINVAL;
  3073			return_error_line = __LINE__;
  3074			goto err_bad_offset;
  3075		}
  3076		off_start_offset = ALIGN(tr->data_size, sizeof(void *));
  3077		buffer_offset = off_start_offset;
  3078		off_end_offset = off_start_offset + tr->offsets_size;
  3079		sg_buf_offset = ALIGN(off_end_offset, sizeof(void *));
  3080		sg_buf_end_offset = sg_buf_offset + extra_buffers_size -
  3081			ALIGN(secctx_sz, sizeof(u64));
  3082		off_min = 0;
  3083		for (buffer_offset = off_start_offset; buffer_offset < off_end_offset;
  3084		     buffer_offset += sizeof(binder_size_t)) {
  3085			struct binder_object_header *hdr;
  3086			size_t object_size;
  3087			struct binder_object object;
  3088			binder_size_t object_offset;
  3089			binder_size_t copy_size;
  3090	
  3091			if (binder_alloc_copy_from_buffer(&target_proc->alloc,
  3092							  &object_offset,
  3093							  t->buffer,
  3094							  buffer_offset,
  3095							  sizeof(object_offset))) {
  3096				return_error = BR_FAILED_REPLY;
  3097				return_error_param = -EINVAL;
  3098				return_error_line = __LINE__;
  3099				goto err_bad_offset;
  3100			}
  3101	
  3102			/*
  3103			 * Copy the source user buffer up to the next object
  3104			 * that will be processed.
  3105			 */
  3106			copy_size = object_offset - user_offset;
  3107			if (copy_size && (user_offset > object_offset ||
  3108					binder_alloc_copy_user_to_buffer(
  3109						&target_proc->alloc,
  3110						t->buffer, user_offset,
  3111						user_buffer + user_offset,
  3112						copy_size))) {
  3113				binder_user_error("%d:%d got transaction with invalid data ptr\n",
  3114						proc->pid, thread->pid);
  3115				return_error = BR_FAILED_REPLY;
  3116				return_error_param = -EFAULT;
  3117				return_error_line = __LINE__;
  3118				goto err_copy_data_failed;
  3119			}
  3120			object_size = binder_get_object(target_proc, user_buffer,
  3121					t->buffer, object_offset, &object);
  3122			if (object_size == 0 || object_offset < off_min) {
  3123				binder_user_error("%d:%d got transaction with invalid offset (%lld, min %lld max %lld) or object.\n",
  3124						  proc->pid, thread->pid,
  3125						  (u64)object_offset,
  3126						  (u64)off_min,
  3127						  (u64)t->buffer->data_size);
  3128				return_error = BR_FAILED_REPLY;
  3129				return_error_param = -EINVAL;
  3130				return_error_line = __LINE__;
  3131				goto err_bad_offset;
  3132			}
  3133			/*
  3134			 * Set offset to the next buffer fragment to be
  3135			 * copied
  3136			 */
  3137			user_offset = object_offset + object_size;
  3138	
  3139			hdr = &object.hdr;
  3140			off_min = object_offset + object_size;
  3141			switch (hdr->type) {
  3142			case BINDER_TYPE_BINDER:
  3143			case BINDER_TYPE_WEAK_BINDER: {
  3144				struct flat_binder_object *fp;
  3145	
  3146				fp = to_flat_binder_object(hdr);
  3147				ret = binder_translate_binder(fp, t, thread);
  3148	
  3149				if (ret < 0 ||
  3150				    binder_alloc_copy_to_buffer(&target_proc->alloc,
  3151								t->buffer,
  3152								object_offset,
  3153								fp, sizeof(*fp))) {
  3154					return_error = BR_FAILED_REPLY;
  3155					return_error_param = ret;
  3156					return_error_line = __LINE__;
  3157					goto err_translate_failed;
  3158				}
  3159			} break;
  3160			case BINDER_TYPE_HANDLE:
  3161			case BINDER_TYPE_WEAK_HANDLE: {
  3162				struct flat_binder_object *fp;
  3163	
  3164				fp = to_flat_binder_object(hdr);
  3165				ret = binder_translate_handle(fp, t, thread);
  3166				if (ret < 0 ||
  3167				    binder_alloc_copy_to_buffer(&target_proc->alloc,
  3168								t->buffer,
  3169								object_offset,
  3170								fp, sizeof(*fp))) {
  3171					return_error = BR_FAILED_REPLY;
  3172					return_error_param = ret;
  3173					return_error_line = __LINE__;
  3174					goto err_translate_failed;
  3175				}
  3176			} break;
  3177	
  3178			case BINDER_TYPE_FD: {
  3179				struct binder_fd_object *fp = to_binder_fd_object(hdr);
  3180				binder_size_t fd_offset = object_offset +
  3181					(uintptr_t)&fp->fd - (uintptr_t)fp;
  3182				int ret = binder_translate_fd(fp->fd, fd_offset, t,
  3183							      thread, in_reply_to);
  3184	
  3185				fp->pad_binder = 0;
  3186				if (ret < 0 ||
  3187				    binder_alloc_copy_to_buffer(&target_proc->alloc,
  3188								t->buffer,
  3189								object_offset,
  3190								fp, sizeof(*fp))) {
  3191					return_error = BR_FAILED_REPLY;
  3192					return_error_param = ret;
  3193					return_error_line = __LINE__;
  3194					goto err_translate_failed;
  3195				}
  3196			} break;
  3197			case BINDER_TYPE_FDA: {
  3198				struct binder_object ptr_object;
  3199				binder_size_t parent_offset;
  3200				struct binder_object user_object;
  3201				size_t user_parent_size;
  3202				struct binder_fd_array_object *fda =
  3203					to_binder_fd_array_object(hdr);
  3204				size_t num_valid = (buffer_offset - off_start_offset) /
  3205							sizeof(binder_size_t);
  3206				struct binder_buffer_object *parent =
  3207					binder_validate_ptr(target_proc, t->buffer,
  3208							    &ptr_object, fda->parent,
  3209							    off_start_offset,
  3210							    &parent_offset,
  3211							    num_valid);
  3212				if (!parent) {
  3213					binder_user_error("%d:%d got transaction with invalid parent offset or type\n",
  3214							  proc->pid, thread->pid);
  3215					return_error = BR_FAILED_REPLY;
  3216					return_error_param = -EINVAL;
  3217					return_error_line = __LINE__;
  3218					goto err_bad_parent;
  3219				}
  3220				if (!binder_validate_fixup(target_proc, t->buffer,
  3221							   off_start_offset,
  3222							   parent_offset,
  3223							   fda->parent_offset,
  3224							   last_fixup_obj_off,
  3225							   last_fixup_min_off)) {
  3226					binder_user_error("%d:%d got transaction with out-of-order buffer fixup\n",
  3227							  proc->pid, thread->pid);
  3228					return_error = BR_FAILED_REPLY;
  3229					return_error_param = -EINVAL;
  3230					return_error_line = __LINE__;
  3231					goto err_bad_parent;
  3232				}
  3233				/*
  3234				 * We need to read the user version of the parent
  3235				 * object to get the original user offset
  3236				 */
  3237				user_parent_size =
  3238					binder_get_object(proc, user_buffer, t->buffer,
  3239							  parent_offset, &user_object);
  3240				if (user_parent_size != sizeof(user_object.bbo)) {
  3241					binder_user_error("%d:%d invalid ptr object size: %zd vs %zd\n",
  3242							  proc->pid, thread->pid,
  3243							  user_parent_size,
  3244							  sizeof(user_object.bbo));
  3245					return_error = BR_FAILED_REPLY;
  3246					return_error_param = -EINVAL;
  3247					return_error_line = __LINE__;
  3248					goto err_bad_parent;
  3249				}
  3250				ret = binder_translate_fd_array(&pf_head, fda,
  3251								user_buffer, parent,
  3252								&user_object.bbo, t,
  3253								thread, in_reply_to);
  3254				if (!ret)
  3255					ret = binder_alloc_copy_to_buffer(&target_proc->alloc,
  3256									  t->buffer,
  3257									  object_offset,
  3258									  fda, sizeof(*fda));
  3259				if (ret) {
  3260					return_error = BR_FAILED_REPLY;
  3261					return_error_param = ret > 0 ? -EINVAL : ret;
  3262					return_error_line = __LINE__;
  3263					goto err_translate_failed;
  3264				}
  3265				last_fixup_obj_off = parent_offset;
  3266				last_fixup_min_off =
  3267					fda->parent_offset + sizeof(u32) * fda->num_fds;
  3268			} break;
  3269			case BINDER_TYPE_PTR: {
  3270				struct binder_buffer_object *bp =
  3271					to_binder_buffer_object(hdr);
  3272				size_t buf_left = sg_buf_end_offset - sg_buf_offset;
  3273				size_t num_valid;
  3274	
  3275				if (bp->length > buf_left) {
  3276					binder_user_error("%d:%d got transaction with too large buffer\n",
  3277							  proc->pid, thread->pid);
  3278					return_error = BR_FAILED_REPLY;
  3279					return_error_param = -EINVAL;
  3280					return_error_line = __LINE__;
  3281					goto err_bad_offset;
  3282				}
  3283				ret = binder_defer_copy(&sgc_head, sg_buf_offset,
  3284					(const void __user *)(uintptr_t)bp->buffer,
  3285					bp->length);
  3286				if (ret) {
  3287					return_error = BR_FAILED_REPLY;
  3288					return_error_param = ret;
  3289					return_error_line = __LINE__;
  3290					goto err_translate_failed;
  3291				}
  3292				/* Fixup buffer pointer to target proc address space */
  3293				bp->buffer = (uintptr_t)
  3294					t->buffer->user_data + sg_buf_offset;
  3295				sg_buf_offset += ALIGN(bp->length, sizeof(u64));
  3296	
  3297				num_valid = (buffer_offset - off_start_offset) /
  3298						sizeof(binder_size_t);
  3299				ret = binder_fixup_parent(&pf_head, t,
  3300							  thread, bp,
  3301							  off_start_offset,
  3302							  num_valid,
  3303							  last_fixup_obj_off,
  3304							  last_fixup_min_off);
  3305				if (ret < 0 ||
  3306				    binder_alloc_copy_to_buffer(&target_proc->alloc,
  3307								t->buffer,
  3308								object_offset,
  3309								bp, sizeof(*bp))) {
  3310					return_error = BR_FAILED_REPLY;
  3311					return_error_param = ret;
  3312					return_error_line = __LINE__;
  3313					goto err_translate_failed;
  3314				}
  3315				last_fixup_obj_off = object_offset;
  3316				last_fixup_min_off = 0;
  3317			} break;
  3318			default:
  3319				binder_user_error("%d:%d got transaction with invalid object type, %x\n",
  3320					proc->pid, thread->pid, hdr->type);
  3321				return_error = BR_FAILED_REPLY;
  3322				return_error_param = -EINVAL;
  3323				return_error_line = __LINE__;
  3324				goto err_bad_object_type;
  3325			}
  3326		}
  3327		/* Done processing objects, copy the rest of the buffer */
  3328		if (binder_alloc_copy_user_to_buffer(
  3329					&target_proc->alloc,
  3330					t->buffer, user_offset,
  3331					user_buffer + user_offset,
  3332					tr->data_size - user_offset)) {
  3333			binder_user_error("%d:%d got transaction with invalid data ptr\n",
  3334					proc->pid, thread->pid);
  3335			return_error = BR_FAILED_REPLY;
  3336			return_error_param = -EFAULT;
  3337			return_error_line = __LINE__;
  3338			goto err_copy_data_failed;
  3339		}
  3340	
  3341		ret = binder_do_deferred_txn_copies(&target_proc->alloc, t->buffer,
  3342						    &sgc_head, &pf_head);
  3343		if (ret) {
  3344			binder_user_error("%d:%d got transaction with invalid offsets ptr\n",
  3345					  proc->pid, thread->pid);
  3346			return_error = BR_FAILED_REPLY;
  3347			return_error_param = ret;
  3348			return_error_line = __LINE__;
  3349			goto err_copy_data_failed;
  3350		}
  3351		if (t->buffer->oneway_spam_suspect)
  3352			tcomplete->type = BINDER_WORK_TRANSACTION_ONEWAY_SPAM_SUSPECT;
  3353		else
  3354			tcomplete->type = BINDER_WORK_TRANSACTION_COMPLETE;
  3355		t->work.type = BINDER_WORK_TRANSACTION;
  3356	
  3357		if (reply) {
  3358			binder_enqueue_thread_work(thread, tcomplete);
  3359			binder_inner_proc_lock(target_proc);
  3360			if (target_thread->is_dead) {
  3361				return_error = BR_DEAD_REPLY;
  3362				binder_inner_proc_unlock(target_proc);
  3363				goto err_dead_proc_or_thread;
  3364			}
  3365			BUG_ON(t->buffer->async_transaction != 0);
  3366			binder_pop_transaction_ilocked(target_thread, in_reply_to);
  3367			binder_enqueue_thread_work_ilocked(target_thread, &t->work);
  3368			target_proc->outstanding_txns++;
  3369			binder_inner_proc_unlock(target_proc);
  3370			wake_up_interruptible_sync(&target_thread->wait);
  3371			binder_free_transaction(in_reply_to);
  3372		} else if (!(t->flags & TF_ONE_WAY)) {
  3373			BUG_ON(t->buffer->async_transaction != 0);
  3374			binder_inner_proc_lock(proc);
  3375			/*
  3376			 * Defer the TRANSACTION_COMPLETE, so we don't return to
  3377			 * userspace immediately; this allows the target process to
  3378			 * immediately start processing this transaction, reducing
  3379			 * latency. We will then return the TRANSACTION_COMPLETE when
  3380			 * the target replies (or there is an error).
  3381			 */
  3382			binder_enqueue_deferred_thread_work_ilocked(thread, tcomplete);
  3383			t->need_reply = 1;
  3384			t->from_parent = thread->transaction_stack;
  3385			thread->transaction_stack = t;
  3386			binder_inner_proc_unlock(proc);
  3387			return_error = binder_proc_transaction(t,
  3388					target_proc, target_thread);
  3389			if (return_error) {
  3390				binder_inner_proc_lock(proc);
  3391				binder_pop_transaction_ilocked(thread, t);
  3392				binder_inner_proc_unlock(proc);
  3393				goto err_dead_proc_or_thread;
  3394			}
  3395		} else {
  3396			BUG_ON(target_node == NULL);
  3397			BUG_ON(t->buffer->async_transaction != 1);
  3398			binder_enqueue_thread_work(thread, tcomplete);
  3399			return_error = binder_proc_transaction(t, target_proc, NULL);
  3400			if (return_error)
  3401				goto err_dead_proc_or_thread;
  3402		}
  3403		if (target_thread)
  3404			binder_thread_dec_tmpref(target_thread);
  3405		binder_proc_dec_tmpref(target_proc);
  3406		if (target_node)
  3407			binder_dec_node_tmpref(target_node);
  3408		/*
  3409		 * write barrier to synchronize with initialization
  3410		 * of log entry
  3411		 */
  3412		smp_wmb();
  3413		WRITE_ONCE(e->debug_id_done, t_debug_id);
  3414		return;
  3415	
  3416	err_dead_proc_or_thread:
  3417		return_error_line = __LINE__;
  3418		binder_dequeue_work(proc, tcomplete);
  3419	err_translate_failed:
  3420	err_bad_object_type:
  3421	err_bad_offset:
  3422	err_bad_parent:
  3423	err_copy_data_failed:
  3424		binder_cleanup_deferred_txn_lists(&sgc_head, &pf_head);
  3425		binder_free_txn_fixups(t);
  3426		trace_binder_transaction_failed_buffer_release(t->buffer);
  3427		binder_transaction_buffer_release(target_proc, NULL, t->buffer,
  3428						  buffer_offset, true);
  3429		if (target_node)
  3430			binder_dec_node_tmpref(target_node);
  3431		target_node = NULL;
  3432		t->buffer->transaction = NULL;
  3433		binder_alloc_free_buf(&target_proc->alloc, t->buffer);
  3434	err_binder_alloc_buf_failed:
  3435	err_bad_extra_size:
  3436		if (secctx)
  3437			security_release_secctx(secctx, secctx_sz);
  3438	err_get_secctx_failed:
  3439		kfree(tcomplete);
  3440		binder_stats_deleted(BINDER_STAT_TRANSACTION_COMPLETE);
  3441	err_alloc_tcomplete_failed:
  3442		if (trace_binder_txn_latency_free_enabled())
  3443			binder_txn_latency_free(t);
  3444		kfree(t);
  3445		binder_stats_deleted(BINDER_STAT_TRANSACTION);
  3446	err_alloc_t_failed:
  3447	err_bad_todo_list:
  3448	err_bad_call_stack:
  3449	err_empty_call_stack:
  3450	err_dead_binder:
  3451	err_invalid_target_handle:
  3452		if (target_thread)
  3453			binder_thread_dec_tmpref(target_thread);
  3454		if (target_proc)
  3455			binder_proc_dec_tmpref(target_proc);
  3456		if (target_node) {
  3457			binder_dec_node(target_node, 1, 0);
  3458			binder_dec_node_tmpref(target_node);
  3459		}
  3460	
  3461		binder_debug(BINDER_DEBUG_FAILED_TRANSACTION,
  3462			     "%d:%d transaction failed %d/%d, size %lld-%lld line %d\n",
  3463			     proc->pid, thread->pid, return_error, return_error_param,
  3464			     (u64)tr->data_size, (u64)tr->offsets_size,
  3465			     return_error_line);
  3466	
  3467		{
  3468			struct binder_transaction_log_entry *fe;
  3469	
  3470			e->return_error = return_error;
  3471			e->return_error_param = return_error_param;
  3472			e->return_error_line = return_error_line;
  3473			fe = binder_transaction_log_add(&binder_transaction_log_failed);
  3474			*fe = *e;
  3475			/*
  3476			 * write barrier to synchronize with initialization
  3477			 * of log entry
  3478			 */
  3479			smp_wmb();
  3480			WRITE_ONCE(e->debug_id_done, t_debug_id);
  3481			WRITE_ONCE(fe->debug_id_done, t_debug_id);
  3482		}
  3483	
  3484		BUG_ON(thread->return_error.cmd != BR_OK);
  3485		if (in_reply_to) {
  3486			thread->return_error.cmd = BR_TRANSACTION_COMPLETE;
  3487			binder_enqueue_thread_work(thread, &thread->return_error.work);
  3488			binder_send_failed_reply(in_reply_to, return_error);
  3489		} else {
  3490			thread->return_error.cmd = return_error;
  3491			binder_enqueue_thread_work(thread, &thread->return_error.work);
  3492		}
  3493	}
  3494	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
