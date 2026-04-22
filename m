Return-Path: <linux-integrity+bounces-9283-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJHzFy1T6WkQXwIAu9opvQ
	(envelope-from <linux-integrity+bounces-9283-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Apr 2026 01:01:01 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D2644B619
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Apr 2026 01:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A66A73029A5D
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Apr 2026 23:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D86628DC4;
	Wed, 22 Apr 2026 23:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WZUNUdlj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD932BFC60
	for <linux-integrity@vger.kernel.org>; Wed, 22 Apr 2026 23:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776898857; cv=pass; b=KMaDt9tfrYHdZkIqIBUJhYdx6DoDFiFtzxGi60bom30MNJ78X2ZhKgvZYuRW3a5Ox1Wam4irOE8zFNaGDKjkj0LrpI772mwj8uRCcGIObFjOmm1LfKSIkkzUCEVlBAnJ483QyiIEMcINCGGXLoWLEtR6mclX3CXdsB9McJMbRnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776898857; c=relaxed/simple;
	bh=thkfWZ7Xkw1V/SIb/fW9osE33ze2y6jHFIKhvVEXsx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PnGrTFFcL/oFnVJewlWOHJEg4tb4nbXyb/O1VGsYkB9i7Mg8CsJEEJiPa2Tai92p0CdnD/UsKP2EA1g+BAPVJWvV0kFw9Q5n/5phvpR6aTN0T8lqq7eKyvVdMWAnWyG3yh6f6xEpAg+f6xbWauZjuFcBr+vr+UgQpJZnCENZ1JQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WZUNUdlj; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-66ba6d3dab3so45999a12.0
        for <linux-integrity@vger.kernel.org>; Wed, 22 Apr 2026 16:00:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776898854; cv=none;
        d=google.com; s=arc-20240605;
        b=lDQwBYgwJaSlx5xGqpp6kek82nnPP29VHuOwxBLfv++s3jhRY4cxDG7c898Pachd47
         zXpAb8hZo+yzuS9KTic5E2Wguo2I8c0E/BqNrUmzQ1M2h8gbdVdlkp8LYmbl6PmHyOVG
         oloCtxvWlee/BmlOt2YWWoisNY3yHaR9Boy7Rbrq90ZeF6VS6yxCkG9W1OJPUol4WxAm
         3kDogdv3z6CohW2rlJLUPcXDODVwC115jC7ZeWuUL/QFma6+ophhaSd4MAUFt6SgwS1Y
         ZbGpHTApwQpVgpzRmuouSWtcexGMVph+9Ihn+DHQNcMiL3Q+mCqwg/kcACzkpGCfBmPV
         nsMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3fLJmqNOas25fSObOj6V05tzu64XNU2J6n0/eauBLow=;
        fh=mNUmOpboVueYNewAg7Xb7RnmonT318SnhR+BO5TqdCc=;
        b=grm5Lwc7epa8jsHIAnCo8kovX3f3U+aN1r4jVNOwd0oRVMPQ7AkcxTTC4neWNmx5Oj
         DZbSdP4CMrcBXNWjWxCq9Efc57YBryB7pTdT3L2ntIYs23lhDjkiXbQyq5lpZldRoGUa
         JtCbq4VQvAYQP0ixwAPkpiPqR4INICFBWOdOUwmP3cUTyo3FF67kszXqO5o4eWDPMk4C
         Ud1yKN/oClt/XlbZXvX6AiLZzHjOu8ykpmhX/cbajyjCjgDI4QBoxwL43DjhNlai/k+L
         tHUwzWSXHx/qMXp9U95FZm9pvhs9mt7slOy3n2y1rwoRE3bgC1cXtlOlzyVM8ijjJn5w
         lI0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776898854; x=1777503654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fLJmqNOas25fSObOj6V05tzu64XNU2J6n0/eauBLow=;
        b=WZUNUdljaPbWBVGsWa5BPoPbELH+vEzIUQr92h3EPDnCDB+HwauQGddZIzM9LQbLgZ
         aPw7Tbvcb+mKOzjZA58JqWJzzb+qagMp+YuSwFXkeJ3U7jjVNmSnAzhXmXMfyqX8tu1I
         b/IT6DhLrun5vb49sVdmIiRAmlPfBTyw/wwwlgKLEgi9b4bL+SLJtiXwEEB1Rru+15bs
         JXd+ao0Fw3m5cXMqCOEMAT078N7FbR8TiN0OCJG9H/tQ+m85oWZSXCnBhhR6OMiOq6p2
         YIy4aRwIbvv0RfbGE/HDH+NQ1W4B8s3WQXYjLEE6sld4GXBJ+MsldGlEArduxMRWaAW5
         FktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776898854; x=1777503654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3fLJmqNOas25fSObOj6V05tzu64XNU2J6n0/eauBLow=;
        b=A7LYYEGHPgLtAFpuxGkw79FozcSYPKDpW7QhYFhM9U/t5UkRUMMMEsOrMWSlwbhXxQ
         20Jp40LrdcnPV+4GWqWIzvcbdoCg5o/wjMLv3eppXJ8b5SRk064TBn95YSrsN157qrhl
         SpS+SwFR+uvR0hGh8FMqrW1Kk9ATJhZFDQsmYMwm+WniI4QZ7xRA4hs+E8FYCsL1YhSz
         swwQPyBXTK7KiYppABRn7NpGXcKPq5EQR0r+Ic+aCAtFzpDXgkRpGNW1WAH2uXNCTN0H
         CASk8KRgIX5HBebJdtSniiMqfSHeu3i75N/7Zah92XocAJQ+ZQ+49SmXabgDfZxszMsw
         ePmA==
X-Gm-Message-State: AOJu0YwjLQaOvpiWkS0sYNPARjsN3bMfhfSFn0TSSLS+rSf3KzUsM1qr
	C6ugyVDKKu+4Z6E4rlMZNQtjYxEJwuiC9p6Jo14bPOjtWhsFkzJBfh7d4m+LIu82fWuCi3XQW0I
	q/pJ09pSoTAC2t/4L7AHKqHlQ6EnQzaIQtyqqXR4p
X-Gm-Gg: AeBDieuQVq4jv1ES3h6wIlz0T8vFSBKg1o5f1cNaKIfbcRHhf/luS8aT8DrGMXRC8/h
	CC0Ujxq/uWxK8lam8y10GXNCzgNbW8qO9J7Qks8f0dxLsGkHaMNk3BqmeUuSr96OhP+TZ334QyN
	+BHluW45AhqgmJu9pjPRmUpdzV4ldpq4Zj7mUEsTNkfsv5bjLQLoTlY9cs5nZ/Kw9pQCuf9hc3u
	ncyZDTzMQZLdjxaNqFpffagnr9/cctrxZqVbHLIJiTOXpnFOiCKe7WdOW6jTFVUPkklQlUxVlEU
	ATnOiRH83vk5nPc4DZy66Ki4mj96Pg==
X-Received: by 2002:a05:6402:14cf:b0:660:efc9:900a with SMTP id
 4fb4d7f45d1cf-674407232dbmr268360a12.10.1776898854096; Wed, 22 Apr 2026
 16:00:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415160006.2275325-1-jacqwong@google.com>
In-Reply-To: <20260415160006.2275325-1-jacqwong@google.com>
From: Axel Rasmussen <axelrasmussen@google.com>
Date: Wed, 22 Apr 2026 16:00:17 -0700
X-Gm-Features: AQROBzD9ZBKPOYEcMxJU3H-o0Xo14S49Sxzsn6f2ft0hfmKL6mT6jdgzsCqLsE0
Message-ID: <CAJHvVcgnsh-PeSsemRd6crAUP85sqzMSZ1mcS08ATJr7cAvAaA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] tpm_tis: fix retry exhaustion and add logging
To: Jacqueline Wong <jacqwong@google.com>
Cc: linux-integrity@vger.kernel.org, jarkko@kernel.org, peterhuewe@gmx.de, 
	jgg@ziepe.ca, jhand@google.com, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmx.de,ziepe.ca,google.com];
	TAGGED_FROM(0.00)[bounces-9283-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axelrasmussen@google.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C7D2644B619
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 9:00=E2=80=AFAM Jacqueline Wong <jacqwong@google.co=
m> wrote:
>
> The Fix:
> - Patch 1: Adds error logs to identify the specific hardware status misma=
tch.
> - Patch 2: Stops execution immediately when retries are exhausted.
>
> v3 changes:
> - Improved code alignment to pass checkpatch --strict.

Thanks for sending the v3 Jacqueline!
I suspect this may have slipped under folks' radar by not CC'ing +linux-ker=
nel@.

>
> v2 changes:
> - Split logging and logic into separate patches.
> - Added retry count to the error message.
> - Included dmesg traces below.
>
> Testing:
> Dmesg traces obtained using error injection to simulate status register m=
ismatches.
>
> Before:
> [  130.288751] tpm tpm0: Operation Timed out
> [  250.306070] tpm tpm0: Operation Timed out
> [  250.310173] tpm tpm0: A TPM error (-62) occurred attempting to determi=
ne the timeouts
>
> After:
> [   10.271547] tpm tpm0: TPM_STS_DATA_EXPECT should be unset. sts =3D 0x0=
0000080
> ...
> [   10.646283] tpm tpm0: TPM_STS_DATA_EXPECT should be unset. sts =3D 0x0=
0000080
> [   10.653461] tpm tpm0: Exhausted 50 tpm_tis_send_data retries
> [   10.659304] tpm tpm0: tpm_try_transmit: send(): error -5
> [   10.665435] tpm tpm0: TPM_STS_DATA_EXPECT should be unset. sts =3D 0x0=
0000080
> ...
> [   11.037198] tpm tpm0: TPM_STS_DATA_EXPECT should be unset. sts =3D 0x0=
0000080
> [   11.044441] tpm tpm0: Exhausted 50 tpm_tis_send_data retries
> [   11.050288] tpm tpm0: tpm_try_transmit: send(): error -5
> [   11.055723] tpm tpm0: A TPM error (-5) occurred attempting to determin=
e the timeouts
>
> Jacqueline Wong (2):
>   tpm: tpm_tis: add error logging for data transfer
>   tpm: tpm_tis: stop transmit if retries are exhausted
>
>  drivers/char/tpm/tpm_tis_core.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> --
> 2.54.0.rc0.605.g598a273b03-goog
>

