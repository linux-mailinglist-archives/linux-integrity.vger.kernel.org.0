Return-Path: <linux-integrity+bounces-8363-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gA8WDz6Te2nOGAIAu9opvQ
	(envelope-from <linux-integrity+bounces-8363-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Jan 2026 18:05:02 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DABF4B29EC
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Jan 2026 18:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 673203008770
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Jan 2026 17:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E4F346A10;
	Thu, 29 Jan 2026 17:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rVLG4EJ6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Vp/0RU4a";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hQKsUp5w";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kDHS7+eU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2403B34251D
	for <linux-integrity@vger.kernel.org>; Thu, 29 Jan 2026 17:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769706129; cv=none; b=uyM/Vc9s2wA+GH4nSTg7q+U6DeUPaY2O5bycEprwU7lqM6Q2XPJxqEmAGAf/UHhoRzIPVQspP/J1TpbzGyK6wnc5chcby1Mx26jSqH5/XHKHgecVq2hDYiOBDzL6fWu8nEaPCGNGk09V2JRANypsOUHcP8X1BOMlBF6aDUkuO2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769706129; c=relaxed/simple;
	bh=GEZjXKJEgy344lsvhrLZfVPuhhuYqEtNua548PuIyGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mV3Q3QJfWVAaLC24QAe/ygT00tV1G4bd69ZoKZ7xYcXgpkK1Caw5AgJQ18somRISucKo+u4JaE6f665Gxb+k1Nw5NXIWs+N7xppsawneNapyLqYmPnmbWtvqa3SSFx+t1IoRykP6FK0CZ8O6VuTbv0DnvfPXxn+4c10xE5Ci4Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rVLG4EJ6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Vp/0RU4a; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hQKsUp5w; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kDHS7+eU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 00D4534214;
	Thu, 29 Jan 2026 17:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769706124; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2KLAb0gtngg0dMxjuY2YbPb4S1CnU/UGU9Et3A57DXE=;
	b=rVLG4EJ6s8EwNDY8j3fLtYUPRlFcvgjhDpPIamRLTUBOAr4zb+fBE02HrBlCMzpNGqOmDJ
	pAFjYPO/KYubhVY+MopuRl5nU8pBo73SCwoNRG3O0c1WBizNDrYWmRn9W+IxevUhH2J4nh
	xwMIIQqC48BDquhRUwWewPRrbkPgDrE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769706124;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2KLAb0gtngg0dMxjuY2YbPb4S1CnU/UGU9Et3A57DXE=;
	b=Vp/0RU4am9As4tETfKn3lfMoRaSXfPE7fLrU2KIlAIafgGOhf4QF50hYvLlSIExwIxKjNm
	2B09QdxfHJrLIBCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hQKsUp5w;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=kDHS7+eU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769706123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2KLAb0gtngg0dMxjuY2YbPb4S1CnU/UGU9Et3A57DXE=;
	b=hQKsUp5wd5hYClKgBdXf+zw7hxy3yix45gSVNFq6AYWYWHsJ5cUFdrlnRcJI3zGxudzL4T
	fhD1DZ7FFdvJQuani0bOdtncr3Y2rBSaSPP41ROzJAxL4iewIyvrCnGn1rXYbqw+KwQxsh
	DYhMIj7JLIWlTudrVBiU1MsVYvBglRs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769706123;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2KLAb0gtngg0dMxjuY2YbPb4S1CnU/UGU9Et3A57DXE=;
	b=kDHS7+eUKTtrOPTX1c3yX6HezXJHCBJVQh8eTyQFlsD3hv8D3li2P8N1dKE9sFjBA7v+Hy
	YLHMf/bN3cSPNbAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C07DD3EA61;
	Thu, 29 Jan 2026 17:02:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id C0eWLoiSe2lZOQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 29 Jan 2026 17:02:00 +0000
Message-ID: <74286aca-a565-489f-ad2c-886c650ea2bc@suse.cz>
Date: Thu, 29 Jan 2026 18:02:00 +0100
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/11] lsm: consolidate all of the LSM framework
 initcalls
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org,
 selinux@vger.kernel.org, john.johansen@canonical.com, zohar@linux.ibm.com,
 roberto.sassu@huawei.com, wufan@kernel.org, mic@digikod.net,
 gnoack@google.com, kees@kernel.org, mortonm@chromium.org,
 casey@schaufler-ca.com, penguin-kernel@i-love.sakura.ne.jp,
 nicolas.bouchinet@oss.cyber.gouv.fr, xiujianfeng@huawei.com,
 linux-mm <linux-mm@kvack.org>, David Hildenbrand <david@redhat.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
References: <20251017202456.484010-36-paul@paul-moore.com>
 <20251017204815.505363-12-paul@paul-moore.com>
 <20251017204815.505363-21-paul@paul-moore.com>
 <0146e385-935b-4f66-9e6d-51bb47ae4bdc@lucifer.local>
 <14638978-b133-457a-ae9c-31ba54e3964c@lucifer.local>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <14638978-b133-457a-ae9c-31ba54e3964c@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TAGGED_FROM(0.00)[bounces-8363-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@suse.cz,linux-integrity@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: DABF4B29EC
X-Rspamd-Action: no action

On 1/29/26 17:48, Lorenzo Stoakes wrote:
> On Thu, Jan 29, 2026 at 04:31:16PM +0000, Lorenzo Stoakes wrote:
> 
> Sorry to clarify here I meant to say - if I set CONFIG_SECURITY but _not_
> CONFIG_SECURITY_SELINUX the tunable does in fact still appear (and afaict
> still work...)
> 
> So LSM_MMAP_MIN_ADDR is really weird to require SECURITY_SELINUX, perhaps a
> historic artifact where we wanted a different default or something like
> this?
> 
> I know that we use that in preference to CONFIG_DEFAULT_MMAP_MIN_ADDR if
> specified.
> 
> The description really probably needs updating.
> 
> The key config here we should be looking at is DEFAULT_MMAP_MIN_ADDR which
> emphatically does _not_ require CONFIG_SECURITY and also in its description
> explicitly mentions the tunable:
> 
> 	  This value can be changed after boot using the
> 	  /proc/sys/vm/mmap_min_addr tunable.
> 
> The mmap_min_addr global value exposed in min_addr.c is referenced in
> several places in mm and other parts of the kernel - fs/exec.c,
> fs/userlandfd.c, kernel/sys.c, mm/mmap.c, mm/vma.c.
> 
> So this now silently going to zero everywhere and ignoring
> CONFIG_DEFAULT_MMAP_MIN_ADDR is surely a userspace-breaking regression and
> needs fixing in rc8?
> 
> Which means that... people can now mmap() at NULL everywhere despite setting
> CONFIG_DEFAULT_MMAP_MIN_ADDR > 0? :)
> 
> That seems like a _really bad idea_ (TM).
> 
> So this is emphatically not a report of a trivial self test break, but
> rather of something more serious AFAICT.
> 
> So yeah I think this has to be reverted/fixed.
Agreed, the mmap_min_addr should stay visible and applied unconditionally.
AFAICS the only relation to SECURITY/LSM is whether CONFIG_LSM_MMAP_MIN_ADDR
is used as an additional lower limit to both CONFIG_DEFAULT_MMAP_MIN_ADDR
and the sysctl-written value?

