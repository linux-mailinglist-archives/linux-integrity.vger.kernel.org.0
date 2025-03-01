Return-Path: <linux-integrity+bounces-5026-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2B9A4A6FA
	for <lists+linux-integrity@lfdr.de>; Sat,  1 Mar 2025 01:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D43A7A2863
	for <lists+linux-integrity@lfdr.de>; Sat,  1 Mar 2025 00:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04272AD2F;
	Sat,  1 Mar 2025 00:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ArDejyUX"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C218F5B
	for <linux-integrity@vger.kernel.org>; Sat,  1 Mar 2025 00:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740788903; cv=none; b=jYmyfGMbMc0S1giK7y37OaNUTZaJznqR8D2f8SJmFCNsaxNOP4BSz2fWpU11hbZV36+cU5PF5h+pL+L74EgrhN88/qBHD83G/W3jL2yBPp0cIr5sQQqAQqFol+HmP8kvTo1riY1I0jv32vm7u2Gd+mB96Ul5L2v2nGIukta7fXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740788903; c=relaxed/simple;
	bh=etpaj8E6HzSygIZNR+IwBTh7AHHX2A8bGyqGJTitllQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUx7pj+iUGtx9UAnMuhmwxjBHBg8dxQj3Y1sTdsi7/0wASoGTKN2BABU2Bp5gDRJxYcT6z7DfOMva0Qi8yhSwK6RBGs4Wo5/I+cPZ6OcULosN0kJSueh5F6eZLKtWXkjWFCyPlTUSvXvfZGxmmN8EYWoqe/UJwSE+CucR6huukQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ArDejyUX; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e89bce647fso21477366d6.3
        for <linux-integrity@vger.kernel.org>; Fri, 28 Feb 2025 16:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1740788901; x=1741393701; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=etpaj8E6HzSygIZNR+IwBTh7AHHX2A8bGyqGJTitllQ=;
        b=ArDejyUXl84+MMfivgzMq/VvKXSev7fsD6mbAsOubTRCNjTTy2yZPBtmBoVIy7Qgho
         lZ5nC5vw9b17rI9kMM1Wt6GHWkjhvlLWuXa+DldAMV8isRjwZOgXbRFdSkvHOe1LeF4M
         VT/8z8v3L17oQhptK7TeAMUL/YF3WhUGSjg5LxjtmHG/ZneuWiMdShDzq5mIcpqNxt+v
         qZn1ZfGHvL0cFHjnIcM9PkTy1PNtUaT4Lz4c8GhhR6ky1kl840bdNbXe/rsKArOGoVIO
         cKnvtViMKUN75903ZKpdZj+2V1J8PVN8rMX/4XRSMjWlnTeARUqpfazB3VnBX0/dQ61T
         WesQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740788901; x=1741393701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etpaj8E6HzSygIZNR+IwBTh7AHHX2A8bGyqGJTitllQ=;
        b=kA0h5APxEeYsThm91zDOSds+nnkXEBbXfKCIFVaBFCVZWGU1H4t2upM7cQZPV66h3x
         30/SXqpy3SzTeOKJ0lidYK4ORL1mqMnasxgHs+irAGftP+xT/gJZOgaZI+zZsE2yeQVR
         rP0Oxe+CfW/zo27JStbAMfNs8S7cGMNY9R5ESrILF2Vd93EYizgb+toI1VPSatojb3WV
         pweYbpyQQBu4m37AQSANtrvodBCur7K2tB7azesdPCqStDzzvQiry79Im8dMsbYa/XCl
         GFmuS7738tFJtIhmY3JhPsas69j4O9HL/EthxSNAfScUKvbfE31gsXOgrypPWB0UaZVE
         NKig==
X-Forwarded-Encrypted: i=1; AJvYcCW6J3DCphPTzDtECEXytUcoYru/9Ti1zKJlqn/0XD6kVppS7eo8LeNFFS7rSQmk3tTX8szPPYyJ74+H6j31UCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX4CTtWmA4wb2Ssgu+9QpUUEhqvmg4OOBfRPJbIbUfwZAZPgvz
	pOPS9IBrHGYsTiXFVbPCjEF9TlSPkhg3Ngn3oj4tpZUTUJRwPyuiutrXmBk8N5DRhkiw0O8PRyf
	u
X-Gm-Gg: ASbGncvCV4AYG7ElvL/qRHSCtOu3Jvb9rvo8Co2qpCssCHsjS93bJRKyTCHcpeBz1t5
	jGP2Xwe14z0QNKT80dqw7dX71ViDARnB0oqu92SVMIhPA9yOm7gB+SI+eMCuI/IVT+GP+lZJGzH
	LPDA1DkP2wKd6nSTaF6L2bq28lD+rJGsETAef21QiGVl3pFFwT/KYAjD9XMYZh4k+FiwELjyeKP
	spuNDbtvnAdmDc35k73/6RxWkydO6t+XyDaA1UoD/HgaljlkDrMrYs0diuCTSOqi/SIWJ2FekYR
	dzI3WmPHvw1NxrQ+1DTNoWl2a6qSIAv0I31yzU3gwnR8LG+8o8Z0/yzr1gXiCml2izmNxW3TWO5
	uEs1UtyjRTOOUEigzBQ==
X-Google-Smtp-Source: AGHT+IGWUW0tauc6sDT2qPhkNDpocp6ePHjchDO/mgzAg7gbE6xKrSwlcBJaiGl9R/g8B01dEdQcag==
X-Received: by 2002:a05:6214:262b:b0:6d8:5642:d9dc with SMTP id 6a1803df08f44-6e8a0c9f135mr80504936d6.11.1740788901200;
        Fri, 28 Feb 2025 16:28:21 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c378d9fe15sm307375585a.66.2025.02.28.16.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 16:28:20 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1toAiJ-00000000VMt-2hZA;
	Fri, 28 Feb 2025 20:28:19 -0400
Date: Fri, 28 Feb 2025 20:28:19 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Peter Huewe <peterhuewe@gmx.de>, x86@kernel.org,
	Dov Murik <dovmurik@linux.ibm.com>, linux-coco@lists.linux.dev,
	Dionna Glaze <dionnaglaze@google.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC PATCH v2 5/6] tpm: add SNP SVSM vTPM driver
Message-ID: <20250301002819.GO5011@ziepe.ca>
References: <20250228170720.144739-1-sgarzare@redhat.com>
 <20250228170720.144739-6-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228170720.144739-6-sgarzare@redhat.com>

On Fri, Feb 28, 2025 at 06:07:19PM +0100, Stefano Garzarella wrote:
> +/*
> + * tpm_svsm_remove() lives in .exit.text. For drivers registered via
> + * module_platform_driver_probe() this is ok because they cannot get unbound
> + * at runtime. So mark the driver struct with __refdata to prevent modpost
> + * triggering a section mismatch warning.
> + */

??? Is that really true? I didn't know that

I thought you could unbind anything using /sys/../unbind?

Jason

