Return-Path: <linux-integrity+bounces-3157-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F225A933C24
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2024 13:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 886DAB2100D
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2024 11:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C9717E919;
	Wed, 17 Jul 2024 11:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="fx9Jrym+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908092E64A;
	Wed, 17 Jul 2024 11:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721215413; cv=pass; b=DgsdvDZHVvRYK0Jg+ERXgJWwd1qyhL//jdSNoL4Oi18vIuJBPc9uaUZpXBoXebbiKJv/b+qLIw0kTXsMCEb4sp8+qCiucHg49/W23/IDVfOQv/fBXsvcQOotdWQuIKjl+VMqM5niKt3Nhj41jSZajfW9BtlWkWNiWwHT5BIJQ7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721215413; c=relaxed/simple;
	bh=LHTysgnozO9aYmf4HnbgQpR6iBDyR/tHHTucjHjpfXw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=HfhE0WSlpRR8yjpduBrouZs61MRvzX1nEzaCNExF6v+oQlTPoMSVu0UjjXCsUiErjvo92BN6Qe8rzR/HcOEqKDWkK42LDh2eBaO0SQSjpA2kWMj0cdHn/4bONT4RprSV1Kv/ObkjoCC7FHnkKZxOp2989BEQjATg0FqHMEFxT/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=fx9Jrym+; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from localhost (83-245-197-232.elisa-laajakaista.fi [83.245.197.232])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sakkinen)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4WPD863TjLzyVP;
	Wed, 17 Jul 2024 14:23:18 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1721215402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LHTysgnozO9aYmf4HnbgQpR6iBDyR/tHHTucjHjpfXw=;
	b=fx9Jrym+W+S+Fa0I13wfz22EvHQZfGiPlFHiRyhzfdhgpcUMw5Vj8lMdPgeZSUibM4aomZ
	ExwnRdP10B08tSrINg5/VdyNsGVml/pQJZKmh12tqW7kI9I+0j0Pj9GtPfwabadxr9lrkM
	4G4q/OpJya//IptIwZ9dyf9LBXIIsQY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1721215402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LHTysgnozO9aYmf4HnbgQpR6iBDyR/tHHTucjHjpfXw=;
	b=xD5iG6Wcdc6hG1WbYwQpBIdfaRANLpkmwZPneP2GqLquazcz64PxX08bd10+0mQTxK0T3I
	QLoxeTEEY6jqNgCZGOOOf/186zvzjQISAJzXrE/bNh22ZiRVLpCn820j50kdngbvmMK81g
	B9iPkRoD5/FJd66TdxrVTiCeXHB98PQ=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1721215402; a=rsa-sha256; cv=none;
	b=kukye0a2Ok08zksmEo/rbmrzG5cj4eUAbvwq2JRszhMV5wFY2tvFmtXW/Z23Qr4NsPc/T7
	+3hygPfJlSTIgDKx65mD27M1cmp7MgSVGqefbMIPaMoksL30tD7UkXww4kcWkT5vw2h+/g
	mLeO/az2+1nmPWEbWkLHGdJZvAnJIwY=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sakkinen smtp.mailfrom=jarkko.sakkinen@iki.fi
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 17 Jul 2024 14:23:18 +0300
Message-Id: <D2RRXPYLJQGO.OU2NRRGKRGUJ@iki.fi>
Cc: <linux-integrity@vger.kernel.org>, <stable@vger.kernel.org>, "James
 Bottomley" <James.Bottomley@hansenpartnership.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, <keyrings@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] tpm: Relocate buf->handles to appropriate place
From: "Jarkko Sakkinen" <jarkko.sakkinen@iki.fi>
To: "Jonathan McDowell" <noodles@earth.li>, "Jarkko Sakkinen"
 <jarkko@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240716185225.873090-1-jarkko@kernel.org>
 <ZpeU_lxLtrpKGk4s@earth.li>
In-Reply-To: <ZpeU_lxLtrpKGk4s@earth.li>

On Wed Jul 17, 2024 at 12:55 PM EEST, Jonathan McDowell wrote:
> Left over from testing? Or should be removed entirely?

Yes. You're right. I noticed it too yesterday, but I'll probably
postpone this patch after holidays and since it is only cosmetic
fix, it can be included to any feature patch set for hmac.

Thanks for the remark however! I'll revisit these when the patch
is needed.

BR, Jarkko

