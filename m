Return-Path: <linux-integrity+bounces-8333-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELAPErTLeGnBtQEAu9opvQ
	(envelope-from <linux-integrity+bounces-8333-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jan 2026 15:29:08 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A7C95AF1
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jan 2026 15:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A72EC306D857
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jan 2026 14:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5806B3570B4;
	Tue, 27 Jan 2026 14:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="i42ENrUD"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1632535503E
	for <linux-integrity@vger.kernel.org>; Tue, 27 Jan 2026 14:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769523859; cv=pass; b=g4W4IeAOo4Js4ksUxLDcpS/a+64vj/vRKWXWjDnSfu4c86H+A3AwFRfFkPwTnMgUKRp/+OufVUI2LNZ9mEqZWma9JZjSCQGSW5cTnFWK8X02MFNct8apFGd+VjjS6iFyK4wL4qq8E2JiGjYthNTjmlg5KIyGa0HmlebcCuxKQOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769523859; c=relaxed/simple;
	bh=8wGhZ57QYRdVwdwGXh3v1vTEUMwIfmYPnQ8VICDIueg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pl3RA9Q6OXIcDlt1gZN+jcUxY5Es7bc4fiyM59xUjHWYfwjKWxOcU4LUaTspOu3lMl63pnP/xdrMw6+9yx1/OehY6JIgQX/cTr8Z+ebwcUoi1r6ScMRLfiwyxhspLmiiu1o5qHgA661mvXqyi+aIhEjG/3Koa0CAY3uCKCpM/cM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=i42ENrUD; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a1388cdac3so42828025ad.0
        for <linux-integrity@vger.kernel.org>; Tue, 27 Jan 2026 06:24:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769523857; cv=none;
        d=google.com; s=arc-20240605;
        b=J43oivo3h/PvgaeSjFLi9iWhONTQ3ATOsLyDRMHLUNDadmprloqNffEY1jV2gqpIaL
         3semhdM6dp+Cqu3iYgidTOU0ranWlxOxqp8ZZXnzAmcb8opFa9h//BjeHFASh1eHQ753
         2y0dTjxIybLyIdSKl1SanFpdLdAeV7hYKyljXUdnYhWuXDwz5KL4yojaBmYq0+LEfkBp
         wxR9pF+8i2lasGzpbBhkeTEhOuSAr5P1xcdX2zeM3XDT9YImDtUCr0SaEAxHeIwoffgi
         Fgnh6CvqvYVYiWNd4vqVB/ykmvD64Iu4uLXoyxvBoGyhb7dC0TALpAX2/EniKi7OfoLI
         ujyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g8tcvewIRp4nWFWaAt8GaNWTar5d4nYaZWbJiaHU2o0=;
        fh=1KoyZLN3Qmec6FUz/WBMlylcLyer/N8FeuARSPQ2pB4=;
        b=HusFlDWb4cX5avNtQxYv4CeqeM0OWXYIuknpQWz8u0wowaUWGqPcHQYq6qmoeyM92T
         bSm3X/beK8E4Qgzkh6kvuf1OLRAYzmGx6u5jly+pNa/aRbbmBjeF/8KZLq1HpTUj4Esd
         TyLazLocjrTUSNDu89wOyOXQLTNrpuoRZSCRjVIzytyh39b3kUow41iAxEd8SZaGuA9G
         E9EJKii9vBC7f3j/CznR4r5AJFtZdYFi7RkUHx3ifFnxE8lXBKygD2JY7E9aMZcjRw03
         8lE5WZxKSk80mAC4TbFfLuJ5fjvyqyjV0JOkIH03kWPyUrfnCz/swckknL2t2/177Dkm
         vwcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1769523857; x=1770128657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8tcvewIRp4nWFWaAt8GaNWTar5d4nYaZWbJiaHU2o0=;
        b=i42ENrUDMUDCGjKkz9nFFlAcDg0PNwtBaKNF3qlouMLTpEnprDZZNW0YCfwyCBpoY1
         nhs0ID4Y0piH5123jsmUq6CAgDP7LC3u9xWeOsF+2cNmlEbhEUtQLshFfBZB6I6lNMZ+
         XUVyVWK05w118524yXjGwJ1RTctZckUMr002cp5LGGiqiguZFM1FgniqI4CSYFl0NJiy
         0PtJlTBfnJDKMIINLIiu8tvVi+ifJeuXTiKLfbr4EwmtvHL41ExgoA6eghpPDcoSiZs6
         lkJP0BBGkJSi/aEyCmWcsXwN8WU6sNJU/Ek/Ij6/KVNdjiy2qE7poBuJj9hGwLUH+Rke
         3Fcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769523857; x=1770128657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g8tcvewIRp4nWFWaAt8GaNWTar5d4nYaZWbJiaHU2o0=;
        b=l0eKmSk2SxtuagUoc8qUsR+N09wIrQbkEm6lBb3ybU0xs2FLFaMdZ3ZXtHac/8rEFl
         n6xGbmcbQV6TyzmomgeQ7tgZjlBWPxAXswvHFo2D23TfDKuavV4lF0Jl+g0ifqgLcHnF
         dvqpjA5/YYgogDZNixOVXBIYwRA4rYiG9AqNBe8Z9j+rt+fu+3BjolTlwInRo9dJsyjB
         VurRQB4hCS6b/AFuSTiB6VCoiLG6WXtkptxB0qwPl57cnRmItybmMPIvBua87mvbL5J5
         32DxUu8TPtqHTusoxfrzRHk8nbQ4Fisl78YlJ/bw1iPuJHkz3oTmU5hoKCVgo23lUw5X
         SgMg==
X-Forwarded-Encrypted: i=1; AJvYcCW5QBejlS4eRNoV2BNiCILsY4KgKgS5S9EyQaIo/FmuDngvJ9d2aVgeT1Y9SWZCPpoZv6wY2zGMuCt9bnA41l4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA9AC5VXvCYYu3b82tjw7IKA4SnPXlYHXwTYiEgZzVx3Rq9/YD
	0uk6sU4iTI0ibCTuzoaUXk5bMmGCrS7RETvYsb1S1UCX7KkHhvt3FRP66iQMmSrG3XWDmLMi9r5
	tH/GNkczFXQjwemrnGBI257PMrRU/v/47DU0BM7Yh
X-Gm-Gg: AZuq6aLOAoQ7bAGPwtD4j6t/VDE2nrgH6WdKk9buN1ZEVNzSBQd1gqt4QbRgxmNmV46
	YRxOzJRjDh7fAmi9+yaCHM/dvhOy3n2635ciFneNZprFmuVQMScM0wZSXdJ4RuUA5xrMUU2KSSj
	M4S3dm1tAjcf8iJyztBPdj2XRQHHpKxRu6Nfe6IuiAHSY1OeZzseEERxJCTk/bYB9p7mwlR2nL2
	k1SRtIg+eDSbXXr53qPwMvJxGfOdReMHbxPoiW+NBq5KlkkvZEKh79IsvJjAYlclC58WcK6sj6A
	Yp/QC8hbD/NDspKhrng32I1EOynV93s3O67Fpqn14QpFz8LwR8eYOlQssVm9ZxD7kxcIEwu55nn
	vpfgtWuf9YA==
X-Received: by 2002:a17:902:ebc3:b0:2a7:683c:afc6 with SMTP id
 d9443c01a7336-2a870dbc9acmr21001815ad.39.1769523857061; Tue, 27 Jan 2026
 06:24:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127-ima-oob-v2-1-f38a18c850cf@arista.com>
In-Reply-To: <20260127-ima-oob-v2-1-f38a18c850cf@arista.com>
From: Dmitry Safonov <dima@arista.com>
Date: Tue, 27 Jan 2026 14:24:05 +0000
X-Gm-Features: AZwV_QgkM7RdmAG2bnPSNf7d7wiBR9A44kYI2A7GzBO9Yj2LAjFQ-cNjrOT6bes
Message-ID: <CAGrbwDStoDBMTB2f-F1jSeak6mqmHvq-ZjpkRNmExeX024=TVA@mail.gmail.com>
Subject: Re: [PATCH v2] ima_fs: Avoid creating measurement lists for
 unsupported hash algos
To: dima@arista.com
Cc: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Silvia Sisinni <silvia.sisinni@polito.it>, 
	Enrico Bravi <enrico.bravi@polito.it>, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[arista.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[arista.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8333-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,polito.it,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dima@arista.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[arista.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arista.com:email,arista.com:dkim,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E7A7C95AF1
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 2:18=E2=80=AFPM Dmitry Safonov via B4 Relay
<devnull+dima.arista.com@kernel.org> wrote:
>
> From: Dmitry Safonov <dima@arista.com>
>
> ima_init_crypto() skips initializing ima_algo_array[i] if the alogorithm

Managed to forget correcting the spelling here ^
Please, ignore v2, version 3 is here:
https://lore.kernel.org/lkml/20260127-ima-oob-v3-1-1dd09f4c2a6a@arista.com/

Excuses for the noise,
           Dmitry

