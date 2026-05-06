Return-Path: <linux-integrity+bounces-9471-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gISgFNdJ+2mYYwMAu9opvQ
	(envelope-from <linux-integrity+bounces-9471-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 06 May 2026 16:01:59 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A11BD4DB94E
	for <lists+linux-integrity@lfdr.de>; Wed, 06 May 2026 16:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9FC730566E0
	for <lists+linux-integrity@lfdr.de>; Wed,  6 May 2026 13:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D4944D685;
	Wed,  6 May 2026 13:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Wh5Dv8Sp"
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70E346AF3D;
	Wed,  6 May 2026 13:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778075841; cv=none; b=dicZRsk4ahoG53N1j/I+49+Xr0G23TR8sK4a7RFLJjci+Z57fgBohXc9nn3SnI4ldqLJe3w24Jeji3n/Guh8TEGEY8JmbfZmioMXTM2U6aCoA5E9Sq4MceJ66V0yX4uAdlMF5mOcsvdqW1hv/lgbRFqKNOd4i+5+teFz/HlZ7g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778075841; c=relaxed/simple;
	bh=qAxl0RqtACkHiwzEDE0zWDfw6tUQYsvu/LQEyZO/AkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PozllEm+9aKI+/LpSGYdy9EF+PUOD1fVbQF46vOUh/BGCOsO+hVnmeuMvYAI48BhIc2ts+tMuoxlfLk0BFV4OS6fEiyH/bNdTxVX9PWNwfLji0D4u1aBXrp3p05Xujy72XY6r0uA3OHcRYiFiyz6BYrFOqJHGPVXpkLQBBL5VWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Wh5Dv8Sp; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7D701A25;
	Wed,  6 May 2026 06:57:12 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C3963F7B4;
	Wed,  6 May 2026 06:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778075838; bh=qAxl0RqtACkHiwzEDE0zWDfw6tUQYsvu/LQEyZO/AkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wh5Dv8Spfr4cehZvmkTo+VGhkybCzPCOIagZiw2rRjeAKplHHfzv6dAzxjDBD+ZWZ
	 UMAZ2SCVCNte9NjytmyRPpe3Jib05FwIYLLNQsNBVfYFFs48R1DKAdnnco/5QrjWcA
	 BL++VUG9CzKbW8Z1Nn4uKYXJ9WhejPuqDlErDvWQ=
Date: Wed, 6 May 2026 14:57:12 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: David Safford <david.safford@gmail.com>,
	Jonathan McDowell <noodles@earth.li>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com, jarkko@kernel.org, jgg@ziepe.ca,
	sudeep.holla@kernel.org, maz@kernel.org, oupton@kernel.org,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, noodles@meta.com,
	sebastianene@google.com
Subject: Re: [PATCH] ima: debugging late_initcall_sync measurements
Message-ID: <aftIuPwNeuzc9nY1@e129823.arm.com>
References: <cover.1777036497.git.noodles@meta.com>
 <7734099f5e7fda5480bca016a9e6707983325fbd.camel@linux.ibm.com>
 <afMlgstqahnZg68h@e129823.arm.com>
 <9f188536f09a2db30877d6bfbb84aeaf2565cccf.camel@linux.ibm.com>
 <CAGWfHUW+AX0Hpuw5Vr5iTSaJKQJ+O_4nWWmU1UR8Z_3XFctHZg@mail.gmail.com>
 <202f90682fe47bb5fb9b08f8678ae00981b5290b.camel@linux.ibm.com>
 <201b9172ac47c6766443c1f2343cab3548f33c29.camel@linux.ibm.com>
 <afrXmRiq7XvSe6yN@e129823.arm.com>
 <9ff4853a8e9932b3a1424f2a6c3347f1723fb5f4.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ff4853a8e9932b3a1424f2a6c3347f1723fb5f4.camel@linux.ibm.com>
X-Rspamd-Queue-Id: A11BD4DB94E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,earth.li,vger.kernel.org,lists.infradead.org,lists.linux.dev,paul-moore.com,namei.org,hallyn.com,huawei.com,oracle.com,kernel.org,ziepe.ca,arm.com,meta.com,google.com];
	TAGGED_FROM(0.00)[bounces-9471-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[arm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yeoreum.yun@arm.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:dkim,e129823.arm.com:mid]

Hi Mimi,

> On Wed, 2026-05-06 at 06:54 +0100, Yeoreum Yun wrote:
> > Hi Mimi,
> > 
> > > On Sun, 2026-05-03 at 07:36 -0400, Mimi Zohar wrote:
> > > > On Fri, 2026-05-01 at 12:52 -0400, David Safford wrote:
> > > > > On Thu, Apr 30, 2026 at 5:43 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > > > > 
> > > > > > On Thu, 2026-04-30 at 10:48 +0100, Yeoreum Yun wrote:
> > > > > > > With above change I confirmed there is no meaurement log
> > > > > > > between boot_aggregate and boot_aggregate_late except "kernel_version"
> > > > > > > But this is ignorable since this UTS measurement is done in
> > > > > > > "ima_init_core() (old: ima_init())" and it is part of ima initialisation.
> > > > > > > 
> > > > > > > 1. ima_policy=tcb
> > > > > > > 
> > > > > > >   # cat /sys/kernel/security/ima/ascii_runtime_measurements
> > > > > > >   10 0adefe762c149c7cec19da62f0da1297fcfbffff ima-ng sha256:0000000000000000000000000000000000000000000000000000000000000000 boot_aggregate
> > > > > > >   10 4e5d73ebadfd8f850cb93ce4de755ba148a9a7d5 ima-ng sha256:0000000000000000000000000000000000000000000000000000000000000000 boot_aggregate_late
> > > > > > >   10 7c23cc970eceec906f7a41bc2fbde770d7092209 ima-ng sha256:72ade6ae3d35cfe5ede7a77b1c0ed1d1782a899445fdcb219c0e994a084a70d5 /bin/busybox
> > > > > snip
> > > > > > > 
> > > > > > > 2. ima_policy=critical_data
> > > > > > > 
> > > > > > >   # cat /sys/kernel/security/ima/ascii_runtime_measurements
> > > > > > >   10 0adefe762c149c7cec19da62f0da1297fcfbffff ima-ng sha256:0000000000000000000000000000000000000000000000000000000000000000 boot_aggregate
> > > > > > >   10 49ab61dd97ea2f759edcb6c6a3387ac67f0aa576 ima-buf sha256:0c907aab3261194f16b0c2a422a82f145bc9b9ecb8fdb633fa43e3e5379f0af2 kernel_version 372e312e302d7263312b // Ignorable since it's generated by ima_init(_core)().
> > > > > > >   10 4e5d73ebadfd8f850cb93ce4de755ba148a9a7d5 ima-ng sha256:0000000000000000000000000000000000000000000000000000000000000000 boot_aggregate_late
> > > > > > > 
> > > > > > > Therefore, init_ima() could move into late_initcall_sync like v1 did:
> > > > > > >   - https://lore.kernel.org/all/20260417175759.3191279-2-yeoreum.yun@arm.com/
> > > > > > 
> > > > > > Thanks, Yeoreum.  It's a bit premature to claim it's "safe" to move the
> > > > > > initcall.  Hopefully others will respond.
> > > > > > 
> > > > > > Mimi
> > > > > 
> > > > > I have also run with this patch on a number of bare metal and virtual machines,
> > > > > running everything from default Fedora 44 to a version with everything turned on
> > > > > (uefi secure boot, UKI with sdboot stub measurements, IMA measurement
> > > > > and appraisal enabled,
> > > > > all systemd measurements on, and systemd using the TPM for root
> > > > > partition decryption.)
> > > > > I too see only the kernel_version event between the normal and late
> > > > > calls, if ima_policy=critical_data.
> > > > 
> > > > Thanks, Dave!  Were all the systems you tested x86_64?  The next step would be
> > > > to test on different arch's (e.g. Z, Power).
> > > 
> > > On both Z and PowerVM, there are ~30 measurements between boot_aggregate and
> > > boot_aggregate_late.  For example, on PowerVM:
> > > 
> > > # grep -n boot_aggregate
> > > /sys/kernel/security/integrity/ima/ascii_runtime_measurements
> > > 
> > > 1:10 f60a05d7354fb34aabc02965216abd3428ea52bb ima-sig
> > > sha256:9887dd089ee19a6517bca10580b02c1bb9aa6cd86c157b6ead8a1c0403f348d5
> > > boot_aggregate 
> > > 31:10 e2592b0d61da6300d3db447b143897a9792231ea ima-sig
> > > sha256:9887dd089ee19a6517bca10580b02c1bb9aa6cd86c157b6ead8a1c0403f348d5
> > > boot_aggregate_late
> > > 
> > > It would be interesting to the results from a Raspberry Pi 5 as well,
> > > with/without a TPM.
> > 
> > Honestly, I find this result hard to accept.
> > 
> > This effectively means that there is code invoking IMA measurement during late_initcall().
> > It also implies that if, in the future, a late_initcall is added that performs
> > an IMA measurement before IMA initialization has occurred accoding to order by linker,
> > that measurement could be missed.
> 
> Exactly.  The results are simply from booting with the builtin "tcb" and
> "critical_data" policies.
> 
> $ sudo grubby --args="ima_policy=\"tcb|critical_data\"" --update-kernel
> /boot/vmlinuz-${SUFFIX}

Thanks. but I still wonder what meaasurements there are between
boot_aggregate and boot_aggregate_late.
Might be there would be key measurements if it takes more than
5 mins before generating boot_aggregate_late but this seems rare.

If you don't mind, would you share the contents of the log between
boot_aggregate and boot_aggregate_late?
since I only get a kernel_version in my environment.

And I think we can collect missing measurements before ima_init_core()
into another separate list than ima_measurements in ima_add_template_entry() and
we can extend them after boot_aggreagate log generation at ima_init_core()
then ima initialisation could be moved to late_initcall_sync like
(just for a test and share concept):

-------&<-------
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 9a1117112fb2..737c1ac8ad77 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -67,6 +67,7 @@ extern int ima_appraise;
 extern struct tpm_chip *ima_tpm_chip;
 extern const char boot_aggregate_name[];
 extern const char boot_aggregate_late_name[];
+extern bool ima_extend_on;

 /* IMA event related data */
 struct ima_event_data {
@@ -107,6 +108,7 @@ struct ima_template_desc {

:...skipping...
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 9a1117112fb2..737c1ac8ad77 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -67,6 +67,7 @@ extern int ima_appraise;
 extern struct tpm_chip *ima_tpm_chip;
 extern const char boot_aggregate_name[];
 extern const char boot_aggregate_late_name[];
+extern bool ima_extend_on;

 /* IMA event related data */
 struct ima_event_data {
@@ -107,6 +108,7 @@ struct ima_template_desc {

 struct ima_template_entry {
        int pcr;
+       int violation;
        struct tpm_digest *digests;
        struct ima_template_desc *template_desc; /* template descriptor */
        u32 template_data_len;
@@ -317,6 +319,7 @@ unsigned long ima_get_binary_runtime_size(void);
 int ima_init_template(void);
 void ima_init_template_list(void);
 int __init ima_init_digests(void);
+int __init ima_extend_deferred(void);
 void __init ima_init_reboot_notifier(void);
 int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
                          void *lsm_data);
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index edd063b99685..f6a2b53c1dcb 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -149,10 +149,22 @@ int __init ima_init_core(bool late)
        rc = ima_init_digests();
        if (rc != 0)
                return rc;
+
+       ima_extend_on = true;
+
        rc = ima_add_boot_aggregate(late);      /* boot aggregate must be first entry */
        if (rc != 0)
                return rc;

+       /* This is just for a test. */
+       if (!late)
+               ima_extend_on = false;
+       else  {
+               rc = ima_extend_deferred();
+               if (rc != 0)
+                       return rc;
+       }
+
        ima_init_policy();

        rc = ima_fs_init();
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 319522450854..81f2ee070fee 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -22,10 +22,13 @@

 #define AUDIT_CAUSE_LEN_MAX 32

+bool ima_extend_on;
+
 /* pre-allocated array of tpm_digest structures to extend a PCR */
 static struct tpm_digest *digests;

 LIST_HEAD(ima_measurements);   /* list of all measurements */
+static LIST_HEAD(ima_extend_deferred_head);
 #ifdef CONFIG_IMA_KEXEC
 static unsigned long binary_runtime_size;
 #else
@@ -91,6 +94,7 @@ static int get_binary_runtime_size(struct ima_template_entry *entry)
        return size;
 }

+
 /* ima_add_template_entry helper function:
  * - Add template entry to the measurement list and hash table, for
  *   all entries except those carried across kexec.
@@ -98,7 +102,8 @@ static int get_binary_runtime_size(struct ima_template_entry *entry)
  * (Called with ima_extend_list_mutex held.)
  */
 static int ima_add_digest_entry(struct ima_template_entry *entry,
-                               bool update_htable)
+                               bool update_htable,
+                               struct list_head *measurements_list)
 {
        struct ima_queue_entry *qe;
        unsigned int key;
@@ -111,7 +116,7 @@ static int ima_add_digest_entry(struct ima_template_entry *entry,
        qe->entry = entry;

        INIT_LIST_HEAD(&qe->later);
-       list_add_tail_rcu(&qe->later, &ima_measurements);
+       list_add_tail_rcu(&qe->later, measurements_list);

        atomic_long_inc(&ima_htable.len);
        if (update_htable) {
@@ -173,6 +178,7 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
        char tpm_audit_cause[AUDIT_CAUSE_LEN_MAX];
        int audit_info = 1;
        int result = 0, tpmresult = 0;
+       struct list_head *measurements_list;

        mutex_lock(&ima_extend_list_mutex);

@@ -195,15 +201,21 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
                }
        }

+
+       entry->violation = violation;
+       measurements_list = (ima_extend_on) ? &ima_measurements :
+                                             &ima_extend_deferred_head;
+
        result = ima_add_digest_entry(entry,
-                                     !IS_ENABLED(CONFIG_IMA_DISABLE_HTABLE));
+                                     !IS_ENABLED(CONFIG_IMA_DISABLE_HTABLE),
+                                     measurements_list);
        if (result < 0) {
                audit_cause = "ENOMEM";
                audit_info = 0;
                goto out;
        }

-       if (violation)          /* invalidate pcr */
+       if (violation)                  /* invalidate pcr */
                digests_arg = digests;

        tpmresult = ima_pcr_extend(digests_arg, entry->pcr);
@@ -225,7 +237,7 @@ int ima_restore_measurement_entry(struct ima_template_entry *entry)
        int result = 0;

        mutex_lock(&ima_extend_list_mutex);
-       result = ima_add_digest_entry(entry, 0);
+       result = ima_add_digest_entry(entry, 0, &ima_measurements);
        mutex_unlock(&ima_extend_list_mutex);
        return result;
 }
@@ -288,3 +300,23 @@ int __init ima_init_digests(void)

        return 0;
 }
+
+int __init ima_extend_deferred(void)
+{
+       guard(mutex)(&ima_extend_list_mutex);
+       struct ima_queue_entry *qe;
+       struct tpm_digest *digests_arg;
+       int ret = 0;
+
+       list_for_each_entry(qe, &ima_extend_deferred_head, later) {
+               digests_arg = (qe->entry->violation) ? digests : qe->entry->digests;
+               ret = ima_pcr_extend(digests_arg, qe->entry->pcr);
+               if (ret)
+                       /* TODO: audit? */
+                       break;
+       }
+
+       list_splice_tail_init(&ima_extend_deferred_head, &ima_measurements);
+
+       return ret;
+}

-- 
Sincerely,
Yeoreum Yun

