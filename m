Return-Path: <linux-integrity+bounces-9292-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFZkJhD56WnkpwIAu9opvQ
	(envelope-from <linux-integrity+bounces-9292-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Apr 2026 12:48:48 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 173AA450E44
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Apr 2026 12:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B26F30C91FF
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Apr 2026 10:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DCF39C01D;
	Thu, 23 Apr 2026 10:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hZKzlPWZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GVJH8JLQ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5743CAE81
	for <linux-integrity@vger.kernel.org>; Thu, 23 Apr 2026 10:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776941023; cv=none; b=DPmPhc+IGt+1BAP40GlGKZnC6fjhLLKFD+5FPD3s5MqdbfO9RuVK3hCOt7JYBdahHc6q86ewsb5uiib/FQkeoDZnakceqf3DggIOORtwwVn9L2jqzHvSMqsLAf+/leKOPHBILuyETjd+3UUSMuf5iTeP7YNbM+4GdOjNyi/rVvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776941023; c=relaxed/simple;
	bh=0MVBmj0UTxxc7uf2d9nD5AhPeN8g9BS4BwA1Dv9oSp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fpm97o94LbLiyVn5/LRldL9pcpgprI+/nsJ8Gk/zQLNoyqjK2EbeGM8IYZCm32mtes5BTYZtAuLoBKD0m8H2P7A/Hkt16nLAFE9NUu+5tIB0yACdQcvDs0geTrvlc7bpGEGuH2KXW8lYH5gj469gTU3IyNNmZYCNVuM2YnlLun4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hZKzlPWZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GVJH8JLQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776941020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WuQW4pBXbKGvyJp/vS2sHGTY1we6BBTCK+8vKgNTI+s=;
	b=hZKzlPWZI9OexrU2kfmTfGWEqMBioPQek6qNE/m2qBIV5mbrgIn/q9ZdQQ2xMCAPz8jdjn
	rVoNsJKMRsP5SQ1quN2JRF0xUrX6VHBu8GSy70ApEfh/pUiZz8qXky9tQtpyJXlQooz4PK
	Q6rETKVdgV7+ZBJ5hUKn1KKxqk6UCJc=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-QR-c6UvQNWuLKnMrxQ1FQQ-1; Thu, 23 Apr 2026 06:43:39 -0400
X-MC-Unique: QR-c6UvQNWuLKnMrxQ1FQQ-1
X-Mimecast-MFC-AGG-ID: QR-c6UvQNWuLKnMrxQ1FQQ_1776941019
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-358f058973fso8138104a91.1
        for <linux-integrity@vger.kernel.org>; Thu, 23 Apr 2026 03:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776941019; x=1777545819; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WuQW4pBXbKGvyJp/vS2sHGTY1we6BBTCK+8vKgNTI+s=;
        b=GVJH8JLQ8qIX0BqU8NS4l+awyBgDoTBGwSPrrFj8xlv/AV7qyqsKHTEum29Fx18ieU
         0cv5oIWnUXdu1toA9KjnmMPA3NiFRojr8oaEYpinU2NRkg5BoZ2DeAkZGiBxTb56Dv7R
         RyhOCLz+SzpvoWRvgcr/+RVzoK4p5Nq0v7UQo65M+yOlLUlSp2Uj6fuNlKebIq7xQdeN
         HUjVQ3irl8rl28uEFvR/ybxt5Z9Jg2jenB308Yhsv8tuTl7O/Ug3NL0Yuchdyhq+t+bT
         /HEUVapR5Vj9SDWv/DKTc2pGCaep86Y/I6VnDjcoH5CCP15CXAOjNJZ4pejZBYhR3qkF
         4PRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776941019; x=1777545819;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WuQW4pBXbKGvyJp/vS2sHGTY1we6BBTCK+8vKgNTI+s=;
        b=NwVuKtMnynUgEW2KN6losC40gelE6XJ8P22jTXcejvc4ocUp7umtvaXF7hm3TMDJ7a
         F5MFMbE2nla1nsnLobUOW3el6zYEkmDLXto5mv1OaUDZzqJNUeLzf6iIitvbwpLMlQ6I
         QEkZFU4cyjhdsCk06gNSkwt62/pPwLKgJ4T6vxMrL1VuajfyOn60JDiTxQ+vZ/D/8Sup
         BDY3w8th8cIKxkUVb9sajZZHhVzTrqtJ0I5pzJ+YD3ObRRWvRRaPvOyRd08lmODlfOdg
         LWOF6r2KzURADUrKSGoUKR6esrhUiyvX2lCkY8d1sIyqhL0kgLk8v+7x8llOtVoMgcvG
         xMDQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Uo/JhiqVW0Act2/z6QaMV5q57Q16W3wpjTocsfhmyzGEm879/F0CVva25zfLpSgAjWiw/GR5mGe2W7fLuhjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxCEzOY2IPmYLEfjRvj5huoGraRCmcn9wJ1qD8UuacMoH/steS
	7moY3p4+PIx7S6fVvvx6fUseXwq10/UEkPzOGe0mRu0GjbDFDasTVPi6a8xPuHWAi9jj8GfblEn
	pgEaBhZnmxiNDasJZ1OVu4+BWVDynCF6Y5VPQycfmAUdwUdXC9ZkJhVeUe4XpJwA+36oOog==
X-Gm-Gg: AeBDiev8+ZMPPbx7kttvnSVNSFp21ql8k8XtbE8+anV6gxYOXYb6GNqNO+zL8ZuqvNI
	B5kKXIHryvqcn1hXCmR3610PJtV58LyvLvIWoBmHHw9K1VXs6yuQTOacLC6jnTwEGx52WRAteGq
	6/15EZUokZf+SBPMtv+N3RRYVUEw7zBrwgOg6WcfgXbfRGwSe1QnomDb5YrWbwNBnqINl5HPXWu
	f9Xj9hxeTGHGHd0P9bGM9K392U8bru0/qvAaFofbh5dD4H6rwXI4NculBMViONTpAyELB2BZnrz
	YRNsL2DjrOqCeHm17VIId2sWgbiV10G6yAYZ7mWHcptBzmgonxvBo9lvYqhOvCB2l/LmnEPeExW
	NiVvaqtfQnKy8KdOv0cQY5ys=
X-Received: by 2002:a17:90b:2e45:b0:35b:e4f8:7cc7 with SMTP id 98e67ed59e1d1-36140473f8amr25177636a91.17.1776941018568;
        Thu, 23 Apr 2026 03:43:38 -0700 (PDT)
X-Received: by 2002:a17:90b:2e45:b0:35b:e4f8:7cc7 with SMTP id 98e67ed59e1d1-36140473f8amr25177605a91.17.1776941018067;
        Thu, 23 Apr 2026 03:43:38 -0700 (PDT)
Received: from fedora ([49.36.110.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa34ea7sm191377915ad.34.2026.04.23.03.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 03:43:37 -0700 (PDT)
Date: Thu, 23 Apr 2026 16:13:27 +0530
From: Arun Menon <armenon@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>,
	Stefan Berger <stefanb@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [RFC 0/4] tpm_crb: Add command and response buffer chunking
 support
Message-ID: <aen3zxxedDXlekRb@fedora>
References: <20260324071803.324774-1-armenon@redhat.com>
 <acJqVjZ7eSxOpSL5@kernel.org>
 <acKGZ33ItHvMkQ_5@fedora>
 <adYTLq0qgWpA1kIS@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <adYTLq0qgWpA1kIS@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9292-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,ziepe.ca,gmx.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[armenon@redhat.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	HAS_WP_URI(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,trustedcomputinggroup.org:url]
X-Rspamd-Queue-Id: 173AA450E44
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 11:34:54AM +0300, Jarkko Sakkinen wrote:
> On Tue, Mar 24, 2026 at 06:11:11PM +0530, Arun Menon wrote:
> > Hi Jarkko,
> > 
> > On Tue, Mar 24, 2026 at 12:41:26PM +0200, Jarkko Sakkinen wrote:
> > > On Tue, Mar 24, 2026 at 12:47:59PM +0530, Arun Menon wrote:
> > > > The new version of TCG TPM v185 (currently under review [1]) supports
> > > > sending data/commands in chunks for the CRB (Command Response Buffer)
> > > > interface. This is in line with the initiative to support PQC algorithms.
> > > > 
> > > > This series implements the logic to send and receive larger TPM
> > > > cmd/rsp between the linux guest and the TPM backend in chunks.
> > > > Currently, the TPM CRB driver is limited by the physical size of the
> > > > MMIO window. When userspace attempts to send a payload that exceeds this
> > > > size, the driver rejects it.
> > > > 
> > > > This series introduces chunking support. The driver now checks the CRB
> > > > interface capability for CRB_INTF_CAP_CRB_CHUNK. If supported by the
> > > > backend, the driver will slice oversized commands into MMIO-sized
> > > > chunks, signalling the backend via CRB_START_NEXT_CHUNK, and finalizing
> > > > with CRB_START_INVOKE. Responses are also read back in a similar chunked
> > > > manner.
> > > > 
> > > > If the backend does not support chunking, the driver retains its legacy
> > > > behaviour and enforces the standard size limits.
> > > > 
> > > > This feature also requires the QEMU to interpret the data in chunks and
> > > > forward it to the TPM backend and subsequently dispatch the TPM response
> > > > in chunks back to the linux guest. This is implemented in [2]
> > > > 
> > > > [1] https://trustedcomputinggroup.org/wp-content/uploads/PC-Client-Specific-Platform-TPM-Profile-for-TPM-2p0-v1p07_rc1_121225.pdf
> > > > [2] https://lore.kernel.org/qemu-devel/20260319135316.37412-1-armenon@redhat.com/
> > > > 
> > > > Arun Menon (4):
> > > >   tpm_crb: Add definition of TPM CRB chunking fields
> > > >   tpm_crb: Add new wrapper function to invoke start method
> > > >   tpm_crb: Implement command and response chunking logic
> > > >   tpm: Increase TPM_BUFSIZE to 64kB for chunking support
> > > > 
> > > >  drivers/char/tpm/tpm.h     |   2 +-
> > > >  drivers/char/tpm/tpm_crb.c | 194 ++++++++++++++++++++++++++-----------
> > > >  2 files changed, 137 insertions(+), 59 deletions(-)
> > > > 
> > > > -- 
> > > > 2.53.0
> > > > 
> > > 
> > > When QEMU has the feature available?
> > 
> > The QEMU patches are in review at the moment,
> > here is the link: https://lore.kernel.org/qemu-devel/20260319135316.37412-1-armenon@redhat.com/
> > Hoping to have them merged soon.
> 
> Right, and additional question: what about swtpm?

Hi Jarkko,

Apologies for the delay in following up.
Regarding your question about swtpm, I’ve looped in Stefan Berger who 
should be able to provide more technical context on that front.

I also wanted to gently point you toward the latest revision of this
series v2, as I’ve addressed some feedback since our last exchange.
latest : https://lore.kernel.org/lkml/20260324181244.17741-1-armenon@redhat.com/

I’ve been working on the QEMU integration side in the meantime to ensure
the end-to-end flow is solid.
qemu link : https://lore.kernel.org/qemu-devel/20260422103018.123608-1-armenon@redhat.com/

I look forward to your feedback when time permits.

> 
> For both, to give detailed review, good enough is their main branch
> (i.e. as long as upstream accepts them I can use them).
> 
> > 
> > > 
> > > BR, Jarkko
> > > 
> > 
> > Regards,
> > Arun Menon
> > 
> 
> BR, Jarkko

Regards,
Arun Menon


