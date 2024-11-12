Return-Path: <linux-integrity+bounces-4087-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D473B9C5FCD
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Nov 2024 19:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 950412848C4
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Nov 2024 18:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBDD21502B;
	Tue, 12 Nov 2024 17:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="leM9g1tw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33552144CB;
	Tue, 12 Nov 2024 17:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731434371; cv=none; b=jAHBXFE25VaprCE8LtVhi3E4WsFx3Rk+8bG4LAqZSrJ/dSO71trFS7cKu9R4gPzhBU2oXewvWCaEnGENf0lgEoyzZ9S5rBqWRvmT1uPSpHiU5WWCtFriOpSp+dsfQTK/EmA72xNkJXtlET8qcuOejEyNk72GXPbIunqxzZWahxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731434371; c=relaxed/simple;
	bh=wXCw1HCeuSt/vVeQUJWNGdsHcK2BT2IDvmf7fX1EKmM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ntfJQitdmI96APAuRNzZ+xiYhSosxRJLOnwTX1maVyIhAZcdWhDqiLY2t3wu2kgfPi1fWD0TQ36eZ9rvYtLvbuek9xWLHpkiYnRJAo+lc5PuqolV8gx0vKWUUvz48QonhRe2Ko1fkqWfZAAY7FjgomBsNpesJNsPc3PD3gl1Uik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=leM9g1tw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D43EC4CECD;
	Tue, 12 Nov 2024 17:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731434371;
	bh=wXCw1HCeuSt/vVeQUJWNGdsHcK2BT2IDvmf7fX1EKmM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=leM9g1twN2GBlyIEkhw5oxePTDf6OIhpbgPxUbE90/j70yrnA7a0FHWIHPLXj0i9E
	 +a3pNz/UVENeTyCJEw7+OslTVgDGFUz0818enYl8IJqYHhN9IeFvtzUiZgaf/zCiko
	 apqazSUwF6UQ0ufWWIIHoATqCBYych5Qn7tUt3/dgsFwfxDqOP2SwcSmpx3HiJzakZ
	 1o52JHYhLmEaL5W14UwhLPLHjX/LxhRgb8KMdcmIU/GsTv0J6Tz1fbTn1ew+527nfD
	 WTSPD6uVz6iqcrUPmcE1BP+q471NEJG7eyOcsvwJQ3fe8WOHpNXciLop8ArURwmLlU
	 hCKHKj/64yYFQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Nov 2024 19:59:27 +0200
Message-Id: <D5KE9BP4M319.2G0BNVFSLUUEX@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <roberto.sassu@huawei.com>, "Tushar
 Sugandhi" <tusharsu@linux.microsoft.com>
Subject: Re: [PATCH v2] ima: Suspend PCR extends and log appends when
 rebooting
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>,
 <linux-integrity@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <zohar@linux.ibm.com>
X-Mailer: aerc 0.18.2
References: <20241112165206.756351-1-stefanb@linux.ibm.com>
In-Reply-To: <20241112165206.756351-1-stefanb@linux.ibm.com>

On Tue Nov 12, 2024 at 6:52 PM EET, Stefan Berger wrote:
> To avoid the following types of error messages due to a failure by the TP=
M
> driver to use the TPM, suspend TPM PCR extensions and the appending of
> entries to the IMA log once IMA's reboot notifier has been called. This
> avoids trying to use the TPM after the TPM subsystem has been shut down.
>
> [111707.685315][    T1] ima: Error Communicating to TPM chip, result: -19
> [111707.685960][    T1] ima: Error Communicating to TPM chip, result: -19
>
> This error could be observed on a ppc64 machine running SuSE Linux where
> processes are still accessing files after devices have been shut down.
>
> Suspending the IMA log and PCR extensions shortly before reboot does not
> seem to open a significant measurement gap since neither TPM quoting woul=
d
> work for attestation nor that new log entries could be written to anywher=
e
> after devices have been shut down. However, there's a time window between
> the invocation of the reboot notifier and the shutdown of devices in
> kernel_restart_prepare() where __usermodehelper_disable() waits for all
> running_helpers to exit. During this time window IMA could now miss log
> entries even though attestation would still work. The reboot of the syste=
m
> shortly after may make this small gap insignificant.
>
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>
> ---
>  v2:
>   - followed Mimi's suggestions
>
> ---
>  security/integrity/ima/ima.h       |  1 +
>  security/integrity/ima/ima_init.c  |  2 ++
>  security/integrity/ima/ima_queue.c | 43 ++++++++++++++++++++++++++++++
>  3 files changed, 46 insertions(+)
>
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 3c323ca213d4..3f1a82b7cd71 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -278,6 +278,7 @@ unsigned long ima_get_binary_runtime_size(void);
>  int ima_init_template(void);
>  void ima_init_template_list(void);
>  int __init ima_init_digests(void);
> +void __init ima_init_reboot_notifier(void);
>  int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event=
,
>  			  void *lsm_data);
> =20
> diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/i=
ma_init.c
> index 4e208239a40e..a2f34f2d8ad7 100644
> --- a/security/integrity/ima/ima_init.c
> +++ b/security/integrity/ima/ima_init.c
> @@ -152,6 +152,8 @@ int __init ima_init(void)
> =20
>  	ima_init_key_queue();
> =20
> +	ima_init_reboot_notifier();
> +
>  	ima_measure_critical_data("kernel_info", "kernel_version",
>  				  UTS_RELEASE, strlen(UTS_RELEASE), false,
>  				  NULL, 0);
> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/=
ima_queue.c
> index 532da87ce519..9b3c9587313f 100644
> --- a/security/integrity/ima/ima_queue.c
> +++ b/security/integrity/ima/ima_queue.c
> @@ -16,6 +16,7 @@
>   */
> =20
>  #include <linux/rculist.h>
> +#include <linux/reboot.h>
>  #include <linux/slab.h>
>  #include "ima.h"
> =20
> @@ -44,6 +45,12 @@ struct ima_h_table ima_htable =3D {
>   */
>  static DEFINE_MUTEX(ima_extend_list_mutex);
> =20
> +/*
> + * Used internally by the kernel to suspend measurements.
> + * Protected by ima_extend_list_mutex.
> + */
> +static bool ima_measurements_suspended;
> +
>  /* lookup up the digest value in the hash table, and return the entry */
>  static struct ima_queue_entry *ima_lookup_digest_entry(u8 *digest_value,
>  						       int pcr)
> @@ -176,6 +183,17 @@ int ima_add_template_entry(struct ima_template_entry=
 *entry, int violation,
>  		}
>  	}
> =20
> +	/*
> +	 * ima_measurements_suspended will be set before the TPM subsystem has
> +	 * been shut down.
> +	 */
> +	if (ima_measurements_suspended) {
> +		audit_cause =3D "measurements_suspended";
> +		audit_info =3D 0;
> +		result =3D -ENODEV;
> +		goto out;
> +	}
> +
>  	result =3D ima_add_digest_entry(entry,
>  				      !IS_ENABLED(CONFIG_IMA_DISABLE_HTABLE));
>  	if (result < 0) {
> @@ -211,6 +229,31 @@ int ima_restore_measurement_entry(struct ima_templat=
e_entry *entry)
>  	return result;
>  }
> =20
> +static void ima_measurements_suspend(void)
> +{
> +	mutex_lock(&ima_extend_list_mutex);
> +	ima_measurements_suspended =3D true;
> +	mutex_unlock(&ima_extend_list_mutex);
> +}
> +
> +static int ima_reboot_notifier(struct notifier_block *nb,
> +			       unsigned long action,
> +			       void *data)
> +{
> +	ima_measurements_suspend();
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block ima_reboot_nb =3D {
> +	.notifier_call =3D ima_reboot_notifier,
> +};
> +
> +void __init ima_init_reboot_notifier(void)
> +{
> +	register_reboot_notifier(&ima_reboot_nb);
> +}
> +
>  int __init ima_init_digests(void)
>  {
>  	u16 digest_size;


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

