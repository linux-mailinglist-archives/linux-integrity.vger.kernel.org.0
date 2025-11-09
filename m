Return-Path: <linux-integrity+bounces-7613-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E4AC43899
	for <lists+linux-integrity@lfdr.de>; Sun, 09 Nov 2025 05:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C50A63B2373
	for <lists+linux-integrity@lfdr.de>; Sun,  9 Nov 2025 04:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504FE14F9FB;
	Sun,  9 Nov 2025 04:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RB5e4/Jp"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287DD42AA9;
	Sun,  9 Nov 2025 04:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762664015; cv=none; b=RSaLRRYqBZJ07qtrtv9ezxEx3LivLxVQwSZ9WfktJsoMrSNRDsq40XTFHm4fgUG5n/MH7012B1YC7RZgP05DRMa6ZXaA+GId7ZTfv70iyqsOoGxWYHtHtxETUOoRPSTvc3ZPHDbY6+trBs2jIERA8AS//bzt/39rujZoIH5ttQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762664015; c=relaxed/simple;
	bh=PGIN1U0HIv4R9SXPOP+Big3jmQVzwzwF8+ZjorSxbmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZ/jRR4Q+Zrn+cRYo+ufpa3VYJ1ismUPmIR2kmMqQrGl94kIh/S9+RHjVk8G1IZhQ0kM3jk8RQA4nAEqIfY01IwqfW3vJZl2Ec16qp5bGVYiQXoDICbJBdPKVgJswgIHg/MfQQEO/NueUG4HbflYF4ZxzN2Ya5I1Yhg7DLcay4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RB5e4/Jp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43583C116B1;
	Sun,  9 Nov 2025 04:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762664014;
	bh=PGIN1U0HIv4R9SXPOP+Big3jmQVzwzwF8+ZjorSxbmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RB5e4/JpWbNgfrZycbUO+JLgIqaP2JAsBB+zmeh+34zpqvhi8hq/B0ycJazmPZDSa
	 K6m+RqMDuAVLw/7jreYgIQJbDoEd/8DHjogfxwd/ZgS63nffUndMUL54d8rd0l9xNS
	 SQudghbIeo2f6mxORRJO0yaqChkAo8UAaSQUr9TViARqT2riIhU3kolJ/F6+gZ48dp
	 CAwhP84dRKQ1FKv8HqBaY71LDURs6B39mqMQ59D6YcW+7Z2nQeMxflM8qJjkqtFePX
	 zv2Jc2dioK2SExl7r7St5OzhLyKPjaiEjS3eezrdar21c0uFOfzgRiiB8mnRfV76oA
	 tDlW7dN0b+Y3A==
Date: Sun, 9 Nov 2025 06:53:31 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] tpm: add WQ_PERCPU to alloc_workqueue users
Message-ID: <aRAeS3TrSyqYFA-Y@kernel.org>
References: <20251106162800.331872-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251106162800.331872-1-marco.crivellari@suse.com>

On Thu, Nov 06, 2025 at 05:28:00PM +0100, Marco Crivellari wrote:
> Currently if a user enqueues a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> This lack of consistency cannot be addressed without refactoring the API.
> 
> alloc_workqueue() treats all queues as per-CPU by default, while unbound
> workqueues must opt-in via WQ_UNBOUND.
> 
> This default is suboptimal: most workloads benefit from unbound queues,
> allowing the scheduler to place worker threads where they’re needed and
> reducing noise when CPUs are isolated.
> 
> This continues the effort to refactor workqueue APIs, which began with
> the introduction of new workqueues and a new alloc_workqueue flag in:
> 
> commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
> commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
> 
> This change adds a new WQ_PERCPU flag to explicitly request
> alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.
> 
> With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
> any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
> must now use WQ_PERCPU.
> 
> Once migration is complete, WQ_UNBOUND can be removed and unbound will
> become the implicit default.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
> ---
>  drivers/char/tpm/tpm-dev-common.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
> index f2a5e09257dd..f942c0c8e402 100644
> --- a/drivers/char/tpm/tpm-dev-common.c
> +++ b/drivers/char/tpm/tpm-dev-common.c
> @@ -275,7 +275,8 @@ void tpm_common_release(struct file *file, struct file_priv *priv)
>  
>  int __init tpm_dev_common_init(void)
>  {
> -	tpm_dev_wq = alloc_workqueue("tpm_dev_wq", WQ_MEM_RECLAIM, 0);
> +	tpm_dev_wq = alloc_workqueue("tpm_dev_wq", WQ_MEM_RECLAIM | WQ_PERCPU,
> +				     0);
>  
>  	return !tpm_dev_wq ? -ENOMEM : 0;
>  }
> -- 
> 2.51.1
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

