Return-Path: <linux-integrity+bounces-5044-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B09A4C703
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Mar 2025 17:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B93273A7C50
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Mar 2025 16:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE2C22AE75;
	Mon,  3 Mar 2025 16:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hFopD38h"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFD52147FD
	for <linux-integrity@vger.kernel.org>; Mon,  3 Mar 2025 16:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741018856; cv=none; b=NyI4iO0tlr5Yex5I0WHVS6AX88AhljM5mB761Xx30hMUZvtCFOXQbEim2Ugobb8YWcW4F6W7FieCgUfTQxaya+1reuYUUDBF9XOPo8K5UHJoLYBEkl7nrhzWf7EIf/q0FQBd0q3Tl1BlYJ2uABetZrLe3r7UrO9iRdzmTJxEkYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741018856; c=relaxed/simple;
	bh=402wUqZufsOsa3QE1ks4oJmtnZKVbPJ2tFfnJxLD8J0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGEy/koENaeGyLCTEDjgrftaXvhn1E24LQDTF51me4yZCqPXgZPF62Wjk4zQZ+gBg4aS20q6JHbz+AR4BPPrsenDrKrVaKJLOi1S560skiBpZA0qxRFovf1xgKH60PYCREPF187bktcoz3PsoVXEiXf8QvoKPcoiET2oanISyNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hFopD38h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741018854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kwE0kZnHaMHXEDQxouFsy+p0EMd7yWpEqSqhQfyrJvg=;
	b=hFopD38hsgLDIHht1Zsl1rEzaNJsIP/paVl6P5f/YQt+TLSSNXQ73YJfUinVwTCxj3/IHO
	j/huCGTHZ1blEOR5Ye+IoC/1tl4MXZtTPYTrQAOzqA0f8p4mQfzO2jqXO/VqPacEhwMM/s
	UoakNXQpM+YlbvLLhZ0AKSJGzWwLrL8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-1ctcEhNyPiePYgPWUNuWaw-1; Mon, 03 Mar 2025 11:20:51 -0500
X-MC-Unique: 1ctcEhNyPiePYgPWUNuWaw-1
X-Mimecast-MFC-AGG-ID: 1ctcEhNyPiePYgPWUNuWaw_1741018851
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-390e50c1d00so3279968f8f.1
        for <linux-integrity@vger.kernel.org>; Mon, 03 Mar 2025 08:20:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741018850; x=1741623650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kwE0kZnHaMHXEDQxouFsy+p0EMd7yWpEqSqhQfyrJvg=;
        b=W7Zwo4Osd9wYK6f3tGqyxiLEF9ZF08dxBwAnKQ8DMBSnQWZgUI5F6/F0YgQKkly5dy
         qCI73/tAsAO1dr4BQOlDdLeF2YY9cG4Sy7CKPDZzmAoVY9F2i9TATepJALhCMigByeHi
         ZGDtcx0SGm/VFB3DcHUaPuVpUnuaP2XQirvQcTqZclT31FrY10d5DtSBmpdIEpBdmq6W
         H2bEDlFb3Gdd/6PmILYZZDuNzppcw9LfdxSXmA3+YXKLQGMCA6ebBUFI4vCSXHS5ezJg
         zSs452rh5VB/bjJcb10blXsZV1sWNEZYe4Dvi0BdBAe/WFUcYfHLV057m2oJee62fi+u
         rR+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUbqDWCLyht+9wic/1ymyb1+3ifV0ZUM7RUg4222KROA8tSaI/TkbZAElLN/vB1trJrJmHDRbVoVs2Y28/dC2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXOwbaGhLPJqdkYzeFKDwLvC5rf4QS9yoQcymYW/ztAMr+Jx0y
	X1JYvwktBtOnSuh0tDpVi/o0VW02pX9HQ8q1oTE7bmg0yKbGrly1pI2/Kh+tdCJJTq4G6zCHBw1
	TGqVnGsGazjQfguqbbo3YtM9xpzXXI1DYHh4Ul9cAf590LsGGIiR6LVmYaMGMpDzt/Q==
X-Gm-Gg: ASbGncuIsiwM4Vwufwlj2yGKj41nHoKNG6EKS+gYl5gzzdIp4d5zLyz8v5Howq/BHyV
	IFI8zzOpcnc/jXWx+0dpSCktqJfbyNE09CuLrTqUtC14H34KGdGccThltxepR1xjQ8Lmz9ntnU8
	D7BWyUUK7gbM9TrNPYlMCs8Z6JZk7EuYQg3MSbqiLtuCsMjw7GRLJ8NlXiXgWEhjS0vBcxCWlQb
	0V50nbd4XdLclL6aO6VE2PoGimHVTaTKPM2GTTNa0r8qJzfIhrSEA+eN3ujoAax1KTbU3rnFNya
	HAOO3RBSbz9H9wcOg5yHoT110+ENC+sH+Xra4OHVtCfEkbKtguwuNdA5VFN+3ttD
X-Received: by 2002:a05:6000:4021:b0:391:a74:d7d7 with SMTP id ffacd0b85a97d-3910a74d8e6mr4864364f8f.8.1741018850660;
        Mon, 03 Mar 2025 08:20:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJkGVDdAKM9Y8PmJ0U+nghUhjVOpFdN8aFO96nlwoN01M7SmNc/xMw3vIU8qZIs/W7CGHyJA==
X-Received: by 2002:a05:6000:4021:b0:391:a74:d7d7 with SMTP id ffacd0b85a97d-3910a74d8e6mr4864327f8f.8.1741018850234;
        Mon, 03 Mar 2025 08:20:50 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47960b6sm15276831f8f.17.2025.03.03.08.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 08:20:49 -0800 (PST)
Date: Mon, 3 Mar 2025 17:20:44 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Claudio Carvalho <cclaudio@linux.ibm.com>, 
	Peter Huewe <peterhuewe@gmx.de>, x86@kernel.org, Dov Murik <dovmurik@linux.ibm.com>, 
	linux-coco@lists.linux.dev, Dionna Glaze <dionnaglaze@google.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dave Hansen <dave.hansen@linux.intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC PATCH v2 0/6] Enlightened vTPM support for SVSM on SEV-SNP
Message-ID: <w4zyf33sixofbqmz4mxyobihicrywjwvjbpmiipcqrlejjfwjd@t7ok7sjni3cn>
References: <20250228170720.144739-1-sgarzare@redhat.com>
 <20250301003009.GP5011@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250301003009.GP5011@ziepe.ca>

On Fri, Feb 28, 2025 at 08:30:09PM -0400, Jason Gunthorpe wrote:
>On Fri, Feb 28, 2025 at 06:07:14PM +0100, Stefano Garzarella wrote:
>> I put RFC back in because we haven't yet decided if this is the best
>> approach to support SVSM vTPM, but I really like to receive feedbacks
>> especially from the maintainer/reviewers of the TPM subsystem, to see if
>> this approach is acceptable.
>
>I didn't look in high detail, but the overall shape is what I was
>thinking about in our previous conversations. Very little TPM code is
>under arch/, we have a nice simplifying helper in the core code, and
>you have a tidy platform device to tie it all together.

Thank you so much for taking a look and confirming that I understood 
your suggestions correctly!

Stefano


