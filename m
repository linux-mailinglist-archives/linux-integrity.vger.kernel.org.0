Return-Path: <linux-integrity+bounces-5334-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3F4A6A4A7
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Mar 2025 12:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF96B8A28F2
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Mar 2025 11:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D3D21CC5D;
	Thu, 20 Mar 2025 11:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UB3L4gbP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F24521D5A4
	for <linux-integrity@vger.kernel.org>; Thu, 20 Mar 2025 11:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742469348; cv=none; b=ctKTdauEEe8cvn4O7RHrm9G3Ljy20DnLmyLiKsL/7l1mGR+WFz6yyXGiFsy2kDlNV8eS/qdQmteAllj+9PtIqPP8S40G0UUbjF9MiytJiXtu+vNQAOjOjdl7lW9TxrcDSthKshA1v52EWlR6gRX/5nifWe+z7RyXWYTxktHEZ7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742469348; c=relaxed/simple;
	bh=GuTQSbeQ/uP+AkFQJqxbkb9TGxhTiSjtGoEhGkkSwoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a1WbVMJfqQys/E8j/a/H/Gw17MAMyEsvzFWkrNHSEqY1rbv1OkaXJ6frU+8zfyF5EhK+FPEUvZ37vQGjOwI+MDSmEOVsANnrt1QxUTR57YDNp1ptAdKLTrno1NfvX2VUq+L1gP2DQTmbOLP9knpTJ7rC9fIqsr55C4a3mC7Jrgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UB3L4gbP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742469346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+zJmTq24j2TSdEMXZRAZzOm55bRd67GQpITR3GiP3qM=;
	b=UB3L4gbP5gXZ1HV0OjVBcpu7tvURL8NYlf4i64uZXdFdq3xweB6tTOw0qgoOl/9fnsAKlY
	6WoikNaIfnbH7pl9HL9uW5ngAGrTl8hoa0ydkMjK3KyAiilx+GIuckvnLx29q13od6vq8D
	nET2J7gs1QdHbjWMGTCBsuSJKOe5BiU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-Kiwp063SN9mEea-5URjbzw-1; Thu, 20 Mar 2025 07:15:42 -0400
X-MC-Unique: Kiwp063SN9mEea-5URjbzw-1
X-Mimecast-MFC-AGG-ID: Kiwp063SN9mEea-5URjbzw_1742469342
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43d22c304adso7662205e9.0
        for <linux-integrity@vger.kernel.org>; Thu, 20 Mar 2025 04:15:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742469341; x=1743074141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+zJmTq24j2TSdEMXZRAZzOm55bRd67GQpITR3GiP3qM=;
        b=Lc2KsQvjpcULUq6qhnR9o/Enu+O+sAsF7aVXTbGOuYvtf85Sfm3snDs72QAnJJOEip
         Nv7yy6rr1+DsyyLWjcFGODwdsYnyRoKjOk+XcwdZsFW6TYkT8C9DvfbOnwdrKbrbxLhZ
         VRxo5egYp3twrHzbqrsc87vcUMdiMWamRySP+qDaCka0zbMLU9ZbnlHRbo8OkNsLl/zj
         QNJEdIX7RvfIBot9XBQ2Q8YOWsCUlonN5ZuVphKUEQk0BEuRGol+nQGY37seP2HGGfNb
         1CImNIXpph3Sh5iHKZrOd4O9lrPu5/2jCwMgR6K6MdAQfWXUgIsK/JyaIML3dlDCo2hy
         D+kg==
X-Forwarded-Encrypted: i=1; AJvYcCVRPwKVcqYi638qQwIJEpHjnCno2SX98kyeXp0Y+tpeXCxvgxiP7bMFyXZuRwcf0PDU5ee2lZ2DYLNuTHLc9IA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTNHn6Kbd9YTukdNUxYjRq8YWDbfQhUXNgkkzEz9NnQLms1mRe
	9zbkmXcWqsvW9scLZgh3fv+j95fOtTmWVpKEqNVs0P+pcQww7oKn3lSTFxQuq0BRosS/JyyB29A
	RnaaaqZHqAs6jo8IPiAiaydxBI+XiwqqwPxOn/bgVAnSXI38wsE2/CoocLjnMveTF8g==
X-Gm-Gg: ASbGncuG7n7bEvOzZSYT8VeuI2o3Wlo9sa/RREmbGcj9ynkcYpF0OprCMZqupXRr0+j
	3/honUv/DUDFmvtDXWdnTfZQM+yBSBm6C1x4jRpmXy37uDPHVcnFkI8hiZX9jTMn9BiQWhD9bES
	GuIBdScdILZ9r6jSCbuIq8H0rVB7P6dmu+fSLPxt0TVA5z6/7378knBgJlIoMF67FBB0JTAJgsJ
	FVQeP4SOSv4AS0yZ8wiQvfhi+N/jqdZdQtSy/7PMnfPL2UQr6ZTGjyiemuFbzW1lCm8fDTjJao8
	VYT1VaqFz5k5DNYGvWa9bECYuHMr0dWeq0lMIZ0X1xH4nSbMO48BAHvVGonE+naJ
X-Received: by 2002:a05:6000:1548:b0:390:e9e0:5cc6 with SMTP id ffacd0b85a97d-39979556803mr2541231f8f.1.1742469341611;
        Thu, 20 Mar 2025 04:15:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqDtibOAZ2y1N0SPi/SBBDfHiePj8pG89PRaxe+lkVMALTkUpR5ddcZlaBUIMF9H9cEQB2cg==
X-Received: by 2002:a05:6000:1548:b0:390:e9e0:5cc6 with SMTP id ffacd0b85a97d-39979556803mr2541194f8f.1.1742469341019;
        Thu, 20 Mar 2025 04:15:41 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-55.business.telecomitalia.it. [87.12.25.55])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f7460fsm45091825e9.28.2025.03.20.04.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 04:15:40 -0700 (PDT)
Date: Thu, 20 Mar 2025 12:15:33 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [RFC PATCH 3/3] tpm/tpm_svsm: use send_recv() op
Message-ID: <7v7v7quud3z2fb5edh3aogzjyvb7lciaqlvjeuii3ca4glvlmq@joxaspk66q5v>
References: <20250311100130.42169-1-sgarzare@redhat.com>
 <20250311100130.42169-4-sgarzare@redhat.com>
 <20250319195818.GC126678@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250319195818.GC126678@ziepe.ca>

On Wed, Mar 19, 2025 at 04:58:18PM -0300, Jason Gunthorpe wrote:
>On Tue, Mar 11, 2025 at 11:01:30AM +0100, Stefano Garzarella wrote:
>> This driver does not support interrupts, and receiving the response is
>> synchronous with sending the command.
>>
>> Let's simplify the driver by implementing the new send_recv() op.
>>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>> Note: this is based on "[PATCH v3 0/4] Enlightened vTPM support for SVSM
>> on SEV-SNP" series [1].
>> If we will merge this series before it, we can just ignore this patch
>> and I'll squash these changes in that series.
>>
>> [1] https://lore.kernel.org/linux-integrity/20250311094225.35129-1-sgarzare@redhat.com/
>> ---
>>  drivers/char/tpm/tpm_svsm.c | 46 ++++++++-----------------------------
>>  1 file changed, 9 insertions(+), 37 deletions(-)
>
>I think the diffstat speaks for itself, you should send this as
>non-RFC

Ack, I'll re-send it.

Thanks,
Stefano


