Return-Path: <linux-integrity+bounces-8489-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id zVcFETotjWkEzwAAu9opvQ
	(envelope-from <linux-integrity+bounces-8489-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Feb 2026 02:30:34 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A598A128F90
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Feb 2026 02:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 69F8B300E5DF
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Feb 2026 01:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8071A704B;
	Thu, 12 Feb 2026 01:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AstQJRbp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rW3cyGYT"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017991A275
	for <linux-integrity@vger.kernel.org>; Thu, 12 Feb 2026 01:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770859830; cv=none; b=Aga8svc+wWzPFHqgEdJ+57pQ33/ZuWnH22FDwyo7p6XcyF5jbX+DjR4TYNkRhpf9i07inNJpl8G98ti2VAKZ3oEGWdcZZFd6agEUHo5UGVYZWDGAAEj1LHypdvJW3PAbk7EAd5PH4M3OHU3zkE4cqwyPj3Ai3tZ8prVkKTs9pek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770859830; c=relaxed/simple;
	bh=KgiA3wWySdtu27emmfFx9TmT091bq+yUVCdDCtZD06E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pmxZbKn4OUdog88qXtKiWKj+6+IDcKwMZnG8f50nmPn9WjfanjSil2H+R3jdeXRBcfVzMPfB+Su/+z4lnQKuFMghx7Lt6pWROQjSNE6GUumHdGVvP3UksHUphIfUHBbcO30ug2gV2B29BGmNwda8WQtUbDjcq8sA6c3HQ8sxx+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AstQJRbp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rW3cyGYT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770859828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bY4z6uuO6pRuPz5GN5A8CgMrwxk/puAYj4i3AjMGr9s=;
	b=AstQJRbpgZMBDfedPSvIG3Xnm5M2B//WLIDQk+TQjtOT3E6HivpB5auxwSEoGzSe4NadKB
	4VX0yKUdUPfE+Bo5cB8Zvun30ncCADH3u1Nmka9q4M8pdlDxKVaJGgVOJpoBiAOn5fAxAe
	d9b0KsQkGsIPO7slZKuV4rPPHflHXtk=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-ofm3FmlfNsGP5slx0h_Rnw-1; Wed, 11 Feb 2026 20:30:26 -0500
X-MC-Unique: ofm3FmlfNsGP5slx0h_Rnw-1
X-Mimecast-MFC-AGG-ID: ofm3FmlfNsGP5slx0h_Rnw_1770859826
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2aad5fec176so51835915ad.2
        for <linux-integrity@vger.kernel.org>; Wed, 11 Feb 2026 17:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770859826; x=1771464626; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bY4z6uuO6pRuPz5GN5A8CgMrwxk/puAYj4i3AjMGr9s=;
        b=rW3cyGYT80WHyfuMp1w5TJpBjPoWv61mDG4ZtpmQeZl2acJA5jaI/fsrzopYwdluq6
         eceo7h06g/zyKxIR3gnA3FmHV14L92jOoHBPE19+OqwlLBuN1uwEXM4QaDz0+yzTaLU/
         PbDeycOK7fHUH0q5tPT+CFWkjMQWUPUfQhaVof4qWIiPF8QpGPt1Fj/3mvlW4XZNfVuS
         1RTou6toE4yMxBi30ggY0JpJhP45wqzfYZMxlfcG3noTczxcrpwCjeDDiR4PKBKZc5Bi
         2S7KsXxXt3YJ92nXBhb10aHZkbUOV+zgWu+PLZnr4h0a0QrJZeXeGxEKGad7AETFmnV2
         jQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770859826; x=1771464626;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bY4z6uuO6pRuPz5GN5A8CgMrwxk/puAYj4i3AjMGr9s=;
        b=etbSCltsJ1LPMLR6AgB1IJhuFRhENN8QwCBdV39yoGgdowzWThWCGzZYTHcv/5SYFy
         tZxpGHBGpmhfWKtiOtebuwpss/dZ8nNmfAkhBLw0zRiprs4zJESovW93nS8UxmI4iD7m
         n9ihMpn7vKSmRw5pdg/UvEygL2FBxRpnAHjlFRyoFKva8bs65Mj6pqUaDUhyG3vxiEb6
         HVMTxNsXohTqMZOjLRdsoQPWbhKZf9jnhs6fo73wjnFneLQ6frVPnFovfQyThiW2lT1+
         WjwvZotrIJ6P+ZPnEhuDMNVzTYECXVjrBhY+GpChh+0gK2ObdUVtGJzy/MZQFlQlou/p
         +wiA==
X-Gm-Message-State: AOJu0YyueIMmCmpuqzh760lWiBnFQc7iA8G7g+m4RwBTBygvgzGTVm0/
	k6kaZLxqZUHVvgjFu7eYTbU48xYvACz6DM55mBVPFRGsy2Y5NQ5Zo+pDPDVif8JAHRRfu6Ri1GX
	1n8mc0bfj4KGDWRc1rdvY5oCm3vTuw4p8mPW8zR9FovE17xmziqrB1GK0gTty08iD8d27zA==
X-Gm-Gg: AZuq6aIe3lk20gWVhkDpLgQuBEs1YmUO+UMtm8xSfW45M+HaMKWBBoi7GWubN+tgY3t
	htDItMeYshBrJJRIq2KDMjG7VBPmzkmtuEgqOAqL28V1UDLRAQTjNCs2R5oEVG5yRw/3KuyagIX
	Q5hVXWUbusviOV5WG8DUN4zgD8P22NaYbWtsBrp+feF3NUWkfGpjaClv8TQMvhoOmbSs6977/Kd
	kgWEyB5CHfolppY+eXY8qxjXPAlZUtQuBZ4H/ejfd1dFGWkUGUalw2/IsaHGqicv4L0eFJmaSa2
	ymYvj7bxzgqkwDPZ2rM7QC5Fh9GbzdbqnvfN143kUiY1gY/ZCYtN9QplRpR82hVgcgoK2XrCx5N
	IdjhdIloM63e3
X-Received: by 2002:a05:6a20:e20d:b0:38d:fc34:c88d with SMTP id adf61e73a8af0-3944887601cmr937855637.55.1770859825458;
        Wed, 11 Feb 2026 17:30:25 -0800 (PST)
X-Received: by 2002:a05:6a20:e20d:b0:38d:fc34:c88d with SMTP id adf61e73a8af0-3944887601cmr937804637.55.1770859824883;
        Wed, 11 Feb 2026 17:30:24 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e197f7e0bsm3248413a12.27.2026.02.11.17.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 17:30:24 -0800 (PST)
Date: Thu, 12 Feb 2026 09:28:43 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, 
	Alexander Egorenkov <egorenar@linux.ibm.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Dave Hansen <dave.hansen@intel.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>, "open list:S390 ARCHITECTURE" <linux-s390@vger.kernel.org>, 
	"open list:EXTENSIBLE FIRMWARE INTERFACE (EFI)" <linux-efi@vger.kernel.org>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, "open list:KEYS/KEYRINGS_INTEGRITY" <keyrings@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] integrity: Make arch_ima_get_secureboot
 integrity-wide
Message-ID: <aY0rZp9ROwfjPgD8@Rk>
References: <20260203041434.872784-1-coxu@redhat.com>
 <20260203041434.872784-2-coxu@redhat.com>
 <66f9d13875e81a965984e2a661e992a3fe43c516.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <66f9d13875e81a965984e2a661e992a3fe43c516.camel@linux.ibm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8489-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.ibm.com,kernel.org,intel.com,huawei.com,ellerman.id.au,gmail.com,redhat.com,alien8.de,linux.intel.com,zytor.com,oracle.com,paul-moore.com,namei.org,hallyn.com,lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[coxu@redhat.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: A598A128F90
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 03:43:08PM -0500, Mimi Zohar wrote:
>On Tue, 2026-02-03 at 12:14 +0800, Coiby Xu wrote:
>> EVM and other LSMs need the ability to query the secure boot status of
>> the system, without directly calling the IMA arch_ima_get_secureboot
>> function. Refactor the secure boot status check into a general function
>> named arch_get_secureboot.
>>
>> Reported-and-suggested-by: Mimi Zohar <zohar@linux.ibm.com>
>> Suggested-by: Roberto Sassu <roberto.sassu@huawei.com>
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>
>Thanks, Coiby.  Other than unnecessarily splitting a line, the patch set looks
>good.  As soon as the open window closes, I'll queue these patches for linux-
>next.

Hi Mimi, thanks for reviewing the patch set! Would you like me to send a
new version with the line splitting issue fixed?

>
>> diff --git a/security/integrity/ima/ima_efi.c b/security/integrity/ima/ima_efi.c
>> index 138029bfcce1..27521d665d33 100644
>> --- a/security/integrity/ima/ima_efi.c
>> +++ b/security/integrity/ima/ima_efi.c
[...]
>>  {
>> -	if (IS_ENABLED(CONFIG_IMA_ARCH_POLICY) && arch_ima_get_secureboot()) {
>> +	if (IS_ENABLED(CONFIG_IMA_ARCH_POLICY) &&
>> +	    arch_get_secureboot()) {
>
>No need to split the line here or below.
>
>
>>  		if (IS_ENABLED(CONFIG_MODULE_SIG))
>>  			set_module_sig_enforced();
>>  		if (IS_ENABLED(CONFIG_KEXEC_SIG))
>> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
>> index 5770cf691912..6d093ac82a45 100644
>> --- a/security/integrity/ima/ima_main.c
>> +++ b/security/integrity/ima/ima_main.c
>> @@ -949,8 +949,8 @@ static int ima_load_data(enum kernel_load_data_id id, bool contents)
>>
>>  	switch (id) {
>>  	case LOADING_KEXEC_IMAGE:
>> -		if (IS_ENABLED(CONFIG_KEXEC_SIG)
>> -		    && arch_ima_get_secureboot()) {
>> +		if (IS_ENABLED(CONFIG_KEXEC_SIG) &&
>> +		    arch_get_secureboot()) {
>
>===>
>
>Mimi
>
>>  			pr_err("impossible to appraise a kernel image without a file descriptor; try using kexec_file_load syscall.\n");
>>  			return -EACCES;
>>  		}
>

-- 
Best regards,
Coiby


