Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 545472D6BCF
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Dec 2020 00:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394206AbgLJXUY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Dec 2020 18:20:24 -0500
Received: from linux.microsoft.com ([13.77.154.182]:37016 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394330AbgLJXUI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Dec 2020 18:20:08 -0500
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 41A4820B717A;
        Thu, 10 Dec 2020 15:19:24 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 41A4820B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1607642365;
        bh=FzUVSYcEmkEJpeeF+NfTc++mI+lgqPFXBkchQXvY9OA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g48dcavkVQaHP36UKUp0PiEZWlosMtMWDrVv8gyciBY4vYqsqWzBeuJ5M8DKSvQf4
         08RQ2O/AZ2/pRFAk4ubRtqRtkcktnTx5J0zxs7TkpQNu6qrxfQXUmD5yoWKMQQatsF
         C4fkSxe90vtKGsteOJrLoZc+GPRtIviKn830ifbc=
Date:   Thu, 10 Dec 2020 17:19:22 -0600
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com, sashal@kernel.org,
        jmorris@namei.org, nramas@linux.microsoft.com,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH v7 6/8] IMA: extend critical data hook to limit the
 measurement based on a label
Message-ID: <20201210231922.GK489768@sequoia>
References: <20201209194212.5131-1-tusharsu@linux.microsoft.com>
 <20201209194212.5131-7-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209194212.5131-7-tusharsu@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2020-12-09 11:42:10, Tushar Sugandhi wrote:
> The IMA hook ima_measure_critical_data() does not support a way to
> specify the source of the critical data provider. Thus, the data
> measurement cannot be constrained based on the data source label
> in the IMA policy.
> 
> Extend the IMA hook ima_measure_critical_data() to support passing 
> the data source label as an input parameter, so that the policy rule can
> be used to limit the measurements based on the label.
> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>

Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>

Tyler

> ---
>  include/linux/ima.h               |  6 ++++--
>  security/integrity/ima/ima_main.c | 11 ++++++++---
>  2 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 675f54db6264..6434287a81cd 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -30,7 +30,8 @@ extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
>  extern void ima_post_path_mknod(struct dentry *dentry);
>  extern int ima_file_hash(struct file *file, char *buf, size_t buf_size);
>  extern void ima_kexec_cmdline(int kernel_fd, const void *buf, int size);
> -extern void ima_measure_critical_data(const char *event_name,
> +extern void ima_measure_critical_data(const char *event_data_source,
> +				      const char *event_name,
>  				      const void *buf, int buf_len,
>  				      bool measure_buf_hash);
>  
> @@ -125,7 +126,8 @@ static inline int ima_file_hash(struct file *file, char *buf, size_t buf_size)
>  }
>  
>  static inline void ima_kexec_cmdline(int kernel_fd, const void *buf, int size) {}
> -static inline void ima_measure_critical_data(const char *event_name,
> +static inline void ima_measure_critical_data(const char *event_data_source,
> +					     const char *event_name,
>  					     const void *buf, int buf_len,
>  					     bool measure_buf_hash) {}
>  #endif /* CONFIG_IMA */
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index ae59f4a4dd70..7c633901f441 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -924,6 +924,7 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
>  
>  /**
>   * ima_measure_critical_data - measure kernel integrity critical data
> + * @event_data_source: kernel data source being measured
>   * @event_name: event name to be used for the buffer entry
>   * @buf: pointer to buffer containing data to measure
>   * @buf_len: length of buffer(in bytes)
> @@ -932,6 +933,9 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
>   * Measure the kernel subsystem data, critical to the integrity of the kernel,
>   * into the IMA log and extend the @pcr.
>   *
> + * Use @event_data_source to describe the kernel data source for the buffer
> + * being measured.
> + *
>   * Use @event_name to describe the state/buffer data change.
>   * Examples of critical data (buf) could be kernel in-memory r/o structures,
>   * hash of the memory structures, or data that represents subsystem state
> @@ -944,17 +948,18 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
>   *
>   * The data (buf) can only be measured, not appraised.
>   */
> -void ima_measure_critical_data(const char *event_name,
> +void ima_measure_critical_data(const char *event_data_source,
> +			       const char *event_name,
>  			       const void *buf, int buf_len,
>  			       bool measure_buf_hash)
>  {
> -	if (!event_name || !buf || !buf_len) {
> +	if (!event_name || !event_data_source || !buf || !buf_len) {
>  		pr_err("Invalid arguments passed to %s().\n", __func__);
>  		return;
>  	}
>  
>  	process_buffer_measurement(NULL, buf, buf_len, event_name,
> -				   CRITICAL_DATA, 0, NULL,
> +				   CRITICAL_DATA, 0, event_data_source,
>  				   measure_buf_hash);
>  }
>  
> -- 
> 2.17.1
> 
