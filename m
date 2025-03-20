Return-Path: <linux-integrity+bounces-5340-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE77CA6A96F
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Mar 2025 16:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55FD61897254
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Mar 2025 15:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD11B1E47C7;
	Thu, 20 Mar 2025 15:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FCNV95CY"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9491E261F;
	Thu, 20 Mar 2025 15:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742482847; cv=none; b=Nn4jHyfcwgH777v4xHGx/6y4CHpM/9hkvPYOjD2sxowT2cuvwgyqztPLYOGaLdGb8CcO0VdALI+QaspvfwkublZNbqoESupq+XIuSW2BLWbfS8WgpnsekVrxY8zFeSbhff6y/OReErN5LdssK/MbRW1sPzSoh9ke6+sTaRFsRKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742482847; c=relaxed/simple;
	bh=Be//gNDiDHACoFa8CWsun5REmHLhpSALE5TV1KvhaHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cjL6KgInsu2N7NclX+yRZcKU36/wGasX3xhgEYMyuuzbtsZabIUIW7YHckv75i8rAjQYTObzy/wIYX6KKNNCpzU4WAHS+ZB3CabfUNupK45AOkusSSLF5iA3guwgjzpYcWEGhzzqs+u+D3Oow03FnU3wbdRB0XAbkMTznJSbiBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FCNV95CY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD67C4CEDD;
	Thu, 20 Mar 2025 15:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742482847;
	bh=Be//gNDiDHACoFa8CWsun5REmHLhpSALE5TV1KvhaHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FCNV95CYJB6Bg57IXbd3x/o8K32MRTrCsSeQZ87G+Z0JbyrSdLDz1kJxPaLcgu9RS
	 btR0xNYoSH2hgn3ffBq9S1otafi7fqLQr/ZmEbGod7EHRn0pG4hk+JfXcN25qtqTxn
	 oYSy89HuRit52h7YhA3gO9JSaW/ByPAZU3i3UJoDhogGSrMdmE/2TRA+DkIhIQMel+
	 4DS2S7ZtIMsoz96N+fF6+937WUu48obBsW0xGD2KAOrPIFcAxY8RBkWiRhIlgJcqBY
	 DKJtks/22C7BK6I7KTVGtaNAMIuM67psLSD3dATtQglklvVgdEivc6TbsGnzaZOUPF
	 qq7zdvPDO4tgQ==
Date: Thu, 20 Mar 2025 17:00:42 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Peter Huewe <peterhuewe@gmx.de>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
	linux-integrity@vger.kernel.org, Dov Murik <dovmurik@linux.ibm.com>,
	Dionna Glaze <dionnaglaze@google.com>, linux-coco@lists.linux.dev,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v3 3/4] tpm: add SNP SVSM vTPM driver
Message-ID: <Z9wtmqGkqPPkXWqP@kernel.org>
References: <20250311094225.35129-1-sgarzare@redhat.com>
 <20250311094225.35129-4-sgarzare@redhat.com>
 <e4eeaead-2277-1f6f-86eb-f80deae2135b@amd.com>
 <Z9gm9iWhk5Zs2NvI@kernel.org>
 <CAGxU2F7fdAi148rB-4c==-qCOW1SJjwf4AzC2=TUhfPXMhR5pQ@mail.gmail.com>
 <1262fa5b-0822-b8d4-26c5-426ffa4e0265@amd.com>
 <qne5fm44dhkbnwc6ldgff76ljt7ecd3cvtf3b3lhos56yyx2ez@qbcv45zbxlhp>
 <20250319234422.GG126678@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319234422.GG126678@ziepe.ca>

On Wed, Mar 19, 2025 at 08:44:22PM -0300, Jason Gunthorpe wrote:
> On Tue, Mar 18, 2025 at 05:18:53PM +0100, Stefano Garzarella wrote:
> 
> > I see, thanks for the clarification!
> > I saw that with devm_get_free_pages() I can easily allocate a
> > resource-managed page, so I'll do that in v4.
> 
> As a general note you should just use kmalloc these days, even for
> PAGE_SIZE. It is efficient and OK.
> 
> Having a struct that is PAGE_SIZE+1 is not efficient and will waste
> a page of memory. That should be avoided ..

Yeah, kzalloc() takes care of this magic. As said, kzalloc() vs
alloc_page() is not an existential question for this patch set :-)

I just would personally use alloc_page(). If nothing else, it does
have some super cosmetic benefits e.g., thinner call stack (when
needing to debug deep, which sometimes happens).

> 
> Jason
> 

BR, Jarkko

