Return-Path: <linux-integrity+bounces-5048-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08366A4C946
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Mar 2025 18:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF21C17AD0C
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Mar 2025 17:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B057C266B4F;
	Mon,  3 Mar 2025 16:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OJOIaP0V"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EE4230277
	for <linux-integrity@vger.kernel.org>; Mon,  3 Mar 2025 16:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741020939; cv=none; b=btusvyF/s9sHo3WNKW6jquUqmyj4Q8q/W2sgjz44zjUbhkMfeQgPiokszRAYWvHmmwH+zFgKkMcm/j53TgRAIhby5Xe1IdDQ7FZyUngDoFVJw58yzb88t9+c7cliIpkb4iJNka5d8cnnDeM+q0gENSa08FbxQJlfWDxM5RVxctg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741020939; c=relaxed/simple;
	bh=UH4NlzYBkkWgbKnndkALjc2/BnPKdAhK1NZQa5X3WkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2qLxsJdbVzug1p9a7JR1zXrUGZc2W2gs6kp1quzAjOzenmsquZt5S57xbdphQn+LbV/MgCy6iXkDs4byGmOo6gJtaOzLIStrSMSf3Dw3tZLyALNtjays6pGqkZU0HjrRVn9u/axYLB7qCfeDSp44z4eOua8SdXTKCS1KeUT0ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=OJOIaP0V; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-474fba180cfso72571cf.3
        for <linux-integrity@vger.kernel.org>; Mon, 03 Mar 2025 08:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1741020937; x=1741625737; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YJqDa+ZdsMQ9ydSfsBA3qoRWbBlsc9jKdUugmc9+LO4=;
        b=OJOIaP0Vxe+u3W1PRLYO3rpVYvJuxpJB+ajjqUENSzTHaKhQY/79ZSK60XQ/Ym5Iwr
         uv7jQ5EtJNoQM8qIX+d4ctGDZgF6DUdlSpIHqtuuYF9sdOEMOaDwNuoDtF6zlK4UNOQb
         onhd3/UeANnsLKxfjXp9PHUuv1T+0O8VVSxbDlX1w1Xqv/OY3UgDYNTnuhmdu9tZta8K
         bB1oyhYeOafYttdLjsKm6bO1rTDMSSWtfdGb6hTTc5dp4RJ72sbU6K5AMZ6rlH04iXQy
         hOVdcGkZGNecpwVkPDSV439RqyEmbuQzMmHKZ6W/JvkiPeCYDiHAbdXSRLtG1Uh/6tYk
         VOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741020937; x=1741625737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJqDa+ZdsMQ9ydSfsBA3qoRWbBlsc9jKdUugmc9+LO4=;
        b=Q/nRqX1GeTiWrd5IAsKj4cNFYon9ccjbu8GZtOcyT6gUbUzOR1mfqhF+eAZMW5iu0F
         AGOpJ4ah6XxeL1d/JKEtJDkyt9Cle7aL5NWQkdhy6+nrLTRxjR9r6f9e4AS7UQbXDL3d
         vrnUETlXbw6Anf4852lecNjyEj/xgVmHpcBaDr/Nvipx7N3sMGXPSGn+8M22IPUb78u6
         FjDPt3ezzQmyWv/gtvHa6298dk6qmlnMrdn7JnlOv+pGw6k8zCE3efrHYrt8b1g55mjK
         w43wIvnRDtbEMnSaKOW+vkBvk1ReLsI72BjwhY6BqIA+tdMOTdCaWhNVd1IXzKe88Whl
         fUxA==
X-Forwarded-Encrypted: i=1; AJvYcCXTfiHQk4bF8GOHU6qHvaztiFyKQ9Nv8cwh9laRUl9sLpNEJVesVwpp1+OPqY7f0oRtrXNN6WVRmQE4/LdevtM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJILoxn0jzvBotRZ+OfrB8qRiijL7rA3ZIMZeT1SVzK1F2uu7i
	whDs2Rnp3u3kkaedn0fCJ6CNYAghXTkL5gwq4dCka14Ho/E0xFmLiZdK8qP2bXI=
X-Gm-Gg: ASbGnctIThCsDVIfKMBtXX+jSz/jQhhOWpaTZXT+Ta4IyvpON2ZdCfBpA5fM/OaiPAO
	fpJ7XKgkEEfne0AlgJ3Fy7ouqmBN4np1tCW4WuaBGvE1J7NkpdFgYPG4gboIcUwFXgsIB5fXuD3
	/m0IRFzTA1ytI8gxqD2odLUetWk5r2BH2agN1Ll6YsjRtyOwHPNnM9UgI704tb5vXaNiCZmvSHj
	JLOBGvb7ReRJJsX6U+bFqsXwteVjVNitHDN193WBzDIdYekK0XMwOYSAl2glXICbf5dBUOGDT6a
	U7c4vgxwEODZ/Tf+oJCy5ITU1APZRGAVvI/miqVRKdQT8+oMcen98BJNYGjKJX45nLgAsoFhnL+
	fUQLYUXl0PGVbx/r4ug==
X-Google-Smtp-Source: AGHT+IG3i30Vik/hq07e5CV5t54ZLHhq9hBAl2BnifWRWrXSNf/6v99OiWRFpkGkprdx8XpLFqILeA==
X-Received: by 2002:a05:622a:22a4:b0:474:d12f:2f3f with SMTP id d75a77b69052e-474d12f3287mr114169491cf.51.1741020936660;
        Mon, 03 Mar 2025 08:55:36 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474dc59d291sm20118051cf.40.2025.03.03.08.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 08:55:36 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tp94p-00000000olC-0YQE;
	Mon, 03 Mar 2025 12:55:35 -0400
Date: Mon, 3 Mar 2025 12:55:35 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Stuart Yoder <stuart.yoder@arm.com>, linux-integrity@vger.kernel.org,
	peterhuewe@gmx.de, sudeep.holla@arm.com, rafael@kernel.org,
	lenb@kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/5] Add support for the TPM FF-A start method
Message-ID: <20250303165535.GT5011@ziepe.ca>
References: <20250217224946.113951-1-stuart.yoder@arm.com>
 <Z8SypwnbJR4g8Bho@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8SypwnbJR4g8Bho@kernel.org>

On Sun, Mar 02, 2025 at 09:33:59PM +0200, Jarkko Sakkinen wrote:
> WARNING: line length of 102 exceeds 100 columns
> #764: FILE: drivers/char/tpm/tpm_crb.c:821:
> +                               FW_BUG "TPM2 ACPI table has wrong size %u for start method type %d\n",

Just ignore that, it is an error in checkpatch. Strings are required to
be long. I suspect FW_BUG confused it.

Jason

