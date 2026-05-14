Return-Path: <linux-integrity+bounces-9531-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHyrFejPBWoPbwIAu9opvQ
	(envelope-from <linux-integrity+bounces-9531-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 14 May 2026 15:36:40 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1F7542604
	for <lists+linux-integrity@lfdr.de>; Thu, 14 May 2026 15:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1E1F300D869
	for <lists+linux-integrity@lfdr.de>; Thu, 14 May 2026 13:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D56D292918;
	Thu, 14 May 2026 13:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lZT3Iobi"
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F118C1A680C;
	Thu, 14 May 2026 13:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778765796; cv=none; b=Ggiz4garyLECQ80lqVzMDGpYBcGCC/2YA4tmA534msa3Eh8qSDZO5Pmx3mC385xZl+GUaMcRNwH88Pcr022K+qk29FyHl+290IxF1+ab73syazswglzodymnIiWcY/QgztJxqpQ4Gfs/2htu2kHCAALg2gt9yZ2j9WbAG2E0l/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778765796; c=relaxed/simple;
	bh=JyiYtFfqX6axN93g0iogwKj81MIiM6cGmLHJ0gGrldE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=V2Mb/h54KyzEtr1lCq/AHM9yWsrAiEZ/FflZKwshLWqo9tYCl8pJks90qggG5QHVhHbpP5ZzXosePNcqfaDAOa1l/kOZbq/5Sbd/vqQZEYR3W1/9pOiiI26Tu513va3bogQFJa2SD7ntWQJ5WByI4C081VQzpv36D8Ox9cVMCXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lZT3Iobi; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF9A51D31;
	Thu, 14 May 2026 06:36:28 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0DDC53F836;
	Thu, 14 May 2026 06:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778765794; bh=JyiYtFfqX6axN93g0iogwKj81MIiM6cGmLHJ0gGrldE=;
	h=Date:From:To:Cc:Subject:From;
	b=lZT3IobihUbwzlne45hFh+f8dQsCqRCZ7RaKxKta2ZR+0AcAxLwDlW1E6JhT4Klu9
	 fgBRJMmDEFIYJGosK7dPPy9XFM2PzgAqXCtHDBiTLiUVI7ZuhKpMV8d1EBG8H9lIab
	 39f3nmfYQQ3ZtphQD3bgeZ16clD7sLeIH9dP+ttM=
Date: Thu, 14 May 2026 14:36:29 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com, ardb@kernel.org,
	jarkko@kernel.org, dhowells@redhat.com, dwmw2@infradead.org,
	serge@hallyn.com, jmorris@namei.org, paul@paul-moore.com,
	sami.mujawar@arm.com, pierre.gondois@arm.com
Subject: [QUESTION] move load_uefi_certs() and keyring initcall to earlier
 initcall
Message-ID: <agXP3ZyE18pAiy77@e129823.arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: AF1F7542604
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9531-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yeoreum.yun@arm.com,linux-integrity@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,e129823.arm.com:mid]
X-Rspamd-Action: no action

Hi all,

Recently, I've found possible module load failure via
request_module() in device_initcall() for absent of certificate loaded by
load_uefi_certs() in below exemplary case:

  - MokListTrustedRT is created.
  - one module is signed with trust-chain with one cert of MokListRT and
    contained in initramfs.
  - loading the above module in device_initcall() get failure since
    relavent certs didn't loaded yet -- load_uefi_certs() is called at 
    late_inicall()

I don't think calling request_module() in the initcall is not a problem
if it's after root_initcall (from device_initcall) where initrd
population is requested when I see the commit e7cb072eb988
("init/initramfs.c: do unpacking asynchronously").

IOW, to address this -- signature verification failure for late loading
of certificates, It seems to movce load_uefi_certs() or other relevant
init functions requires to move to "rootfs_initcall()".

Unfortunately, Moving the load_uefi_certs() doesn't seems easy because
keyring infrastructure is initailised at device_initcall() via
relevant init functions.

So, I would like to introduce two initcalls macro which using pre-exist
initcall macro to address above situation --

  - keyring_initcall() (which is wrapper of subsys_initcall()).
  - cert_initcall() (which is wrapper of rootfs_initcall()).

so that for init functions which initalise keyring infrastructure,
for example, the function where calls keyring_alloc() like:
   - system_trusted_keyring_init()
   - blacklist_init()
   - machine_keyring_init()
   - platform_keyring_init()
   - ima_mok_init()

to be replaced from device_initcall() to subsys_initcall() with keyring_initcall()

and for functions which load certificates or late init relevant keyring
like:
   - load_system_certificate_list()
   - load_uefi_certs()
   - load_powerpc_certs()
   - load_ipl_certs()
   - big_key_init()
   - init_root_keyring()
   - init_trusted()
   - init_encrypted()

to be called from late_initcall() to rootfs_initcall() with cert_initcall().

Am I missing something, or is there perhaps a better idea?

Thanks.

-- 
Sincerely,
Yeoreum Yun

