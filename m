Return-Path: <linux-integrity+bounces-4863-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DB5A3A1CA
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Feb 2025 16:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E0D1173811
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Feb 2025 15:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBB326E622;
	Tue, 18 Feb 2025 15:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="dXbnkr7e"
X-Original-To: linux-integrity@vger.kernel.org
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EEF26A098;
	Tue, 18 Feb 2025 15:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739894004; cv=pass; b=VtWMQZQheM93LG3HcGReVnbAm6FyetKonT/1CwbXkOwE5cQtTurwbvUKrD0nfvGLbHgPIkB9h0zIQmW6couvbt3C4PRjFrHR90bro99hoPxRDurtDm+jZu3XfZUcuMNy7zaVwQzMqyeLP/vkba0BTOLo5LB3fFsGGSNmjKosxt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739894004; c=relaxed/simple;
	bh=EScDoQ/YaO/GXnxZCH19+KT21MM44vRIdgG8iRgg2Tg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MRnk75fuEOAcvc+hujdjifBIc/5UEfpkThBAI0Q4czk29DD+l7obgzXtdms92HwbNm2x6x0lUWnP8eCH2tKspN+1ORVnO1IbNQDE8qI232VSOuPjUjky49rYUoWDEjNEVeigaMwTnnIYjxy3xjFV4nXizh27BhES3sFXd79vyFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=dXbnkr7e; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from localhost (83-245-197-208.elisa-laajakaista.fi [83.245.197.208])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sakkinen)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4Yy3vz70YyzyNF;
	Tue, 18 Feb 2025 17:53:19 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1739894000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xTXjUvw4sz5pHCvq/YnCR33TeICu4U57nU6+gb63/7I=;
	b=dXbnkr7e5AzyAxaMZvhsNsyN6o3Zwyrw09VGn47srMTL77MS+iATxaKqcEIX3HTbJcIx5z
	K2qRKL1wlMl5unSJ9Hbxgp4lr5Sz4dnD0lNnS8bU2408kyZuTJbazAtOsR8P+t9ttNlCoY
	vngIjC5zkhO54F3OBjIuScxsJO+Uhus=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1739894000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xTXjUvw4sz5pHCvq/YnCR33TeICu4U57nU6+gb63/7I=;
	b=Fq2Km5LBhn0QlD7B5fJTi1tRiq3fn2v/JqwiTF28rpt8xISl9FqXZkhCGy0E/gYNkFvTEV
	HScxbu43D2CNnbLKz4WKvTV5O/eayLTxTlH9pfMbFoN6npNiYyoaNhx98EhZUayVaARfI3
	lc0tbA1SriKpx/GzAtPgIahOTFRComQ=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sakkinen smtp.mailfrom=jarkko.sakkinen@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1739894000; a=rsa-sha256; cv=none;
	b=aF8vgvbrRAqtSJPJko/O1JK+rv4hf0AKNsZZerrNNs07iNMS18xTXLmN6j+K8qXSsyrZqi
	mVnuVH2/mbaGVjBbPMOULjccbUR3z6zQc9vHf+FC1o5tI4kZz+eWfhPhBHP0+Tj2i1r6jq
	MAHyzlx+jjyDBQXi0PcjOkHcOxZUUvw=
Message-ID: <3bb5c58bc83d49e01c2a3a849e831b00e635aaae.camel@iki.fi>
Subject: Re: [PATCH v4 3/5] ACPICA: add start method for Arm FF-A
From: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
To: Stuart Yoder <stuart.yoder@arm.com>, linux-integrity@vger.kernel.org, 
	jarkko@kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca, sudeep.holla@arm.com, 
	rafael@kernel.org, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 18 Feb 2025 17:53:18 +0200
In-Reply-To: <20250217224946.113951-4-stuart.yoder@arm.com>
References: <20250217224946.113951-1-stuart.yoder@arm.com>
	 <20250217224946.113951-4-stuart.yoder@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-02-17 at 16:49 -0600, Stuart Yoder wrote:
> Add TPM start method for Arm FF-A defined in the TCG ACPI
> specification v1.4.
>=20
> Link: https://github.com/acpica/acpica/pull/1000
> Signed-off-by: Stuart Yoder <stuart.yoder@arm.com>
> ---
> =C2=A0include/acpi/actbl3.h | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
> index 5cd755143b7d..a97b1dbab975 100644
> --- a/include/acpi/actbl3.h
> +++ b/include/acpi/actbl3.h
> @@ -466,6 +466,7 @@ struct acpi_tpm2_phy {
> =C2=A0#define ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 11	/* V1.2 Rev
> 8 */
> =C2=A0#define ACPI_TPM2_RESERVED=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 12
> =C2=A0#define ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 13
> +#define ACPI_TPM2_CRB_WITH_ARM_FFA=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 15
> =C2=A0
> =C2=A0/* Optional trailer appears after any start_method subtables */
> =C2=A0

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

