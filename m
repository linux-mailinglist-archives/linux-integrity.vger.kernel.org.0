Return-Path: <linux-integrity+bounces-6810-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E00B23D54
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Aug 2025 02:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 807981AA4A1F
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Aug 2025 00:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF76F1F61C;
	Wed, 13 Aug 2025 00:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+Mq0EWp"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCF42C0F92;
	Wed, 13 Aug 2025 00:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755046105; cv=none; b=Phe1xrPn3fLDEBtgEQPzjCgy2pXrrFEVcU8BLjLkdkp8B8sNCbjcdgZ9czGmslbq/wA9DiFuXixdHx8hmQKjYBA+DkALA945bho/GAnBP58QzM+azvcwa1/qho5NoU2veddEvrLbardOtRZLhXN4SJrFog7gx2pZsDvAi4GkpFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755046105; c=relaxed/simple;
	bh=5jlaVkoazA/uK2otNb+2tprjlUa4zKnguyC+SLUu1V4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDipQxWV7KwNZGjaycBoycD3WGyXU8qZz0Zmg12Lb2u6Q7VFNkKYafkrRc/A6gLYcz9U66fpMRYRBa9gPzTj2adjcbwASacgz8lemnb8O28B1lID3S2tVEpoVwV8Foh/m6LtDVqx9JQkWei2ca/z9WyfG+sKMX9CeUA7DgetJW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+Mq0EWp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E888CC4CEF0;
	Wed, 13 Aug 2025 00:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755046105;
	bh=5jlaVkoazA/uK2otNb+2tprjlUa4zKnguyC+SLUu1V4=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=m+Mq0EWpf+LK7mTEQHi0JSGAX0sUmEkxlkB0pkz6E8FFlAYdbaiPcpRE3SaUye6nt
	 r97oT5MfzSgnnTpgn+6b1pCVGjvKnNDalawobpQdPlhzklfWByPelMY8s5mmwOwmvN
	 IWRMT3PRQlc+BrdnpQ3GTk7ubpzA9AV+y+JU4RwBMTLa11itZGKSBoexL6cJrneu5/
	 lzCGeC6RhuZEg69jx8OLuxqNWEawVubFRpmqKl/OI0/Q3C7G8L/6b7So0KyQMwnkTJ
	 KKbR97pWbxzbHiqT/xpN54VTiDmQTU2z4OIiG7giBFqgh7F2QH/DU5uVkkDQ8MwR2B
	 1d5I9pN1toAiQ==
Date: Wed, 13 Aug 2025 03:48:21 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: tpm2@lists.linux.dev, linux-integrity@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: tpm2_protocol
Message-ID: <aJvg1UO_soccGwnY@kernel.org>
References: <aJs6rWexGNsH45_Z@kernel.org>
 <aJve98-cGPKdEOlB@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJve98-cGPKdEOlB@kernel.org>

On Wed, Aug 13, 2025 at 03:40:27AM +0300, Jarkko Sakkinen wrote:
> This is designed as unipolar TPM protocol stack i.e. it's designed not
> only send commands and receive responses, but also send responses and
> receive commands.
 
Unipolarity has been my design goal from the get go given that:

1. It enables high granularity filtering i.e. as capable or more capable
   resource managers in kernel as pre-existing user space resource
   managers (once the implementation has matured enough ofc but it
   has the core design principles right I think).
2. Software defined TPM devices e.g., in-kernel TPM emulators and
   interoperability layers for other crypto devices and confidential
   computing technologies. I'm not sure if anyone wants anything
   like this, just plain highilighting the possibilities.

BR, Jarkko

