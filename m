Return-Path: <linux-integrity+bounces-3643-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A930C97CA4B
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Sep 2024 15:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49CBB285E34
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Sep 2024 13:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB9A19F461;
	Thu, 19 Sep 2024 13:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FbhM8SH1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BB819D8BB;
	Thu, 19 Sep 2024 13:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726753330; cv=none; b=ppYnwo15xCtm+NYVoecZkWB8L/iUanqhzk3IK6+wkjcZOShx1cQ5+AybiaAXwRuNhuMy2/RYY0TpPiRdZmkkSOj3lrk/V+5OChY6sPWeLlIQOsF1QEhQM1y3EQuR4HKhxr7S6vofmp/nn2oIyOlyPs4tztQx/cnNYp7XP4AdljM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726753330; c=relaxed/simple;
	bh=Ddg68ZWVidcqPqMiyOPkT4CJlaowbdtqhlHc9z5kbD8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=hldlZdlfiej/Fn/c+DPGUQwz7QJWoGMd/M+7Pi9kbXsER3Aqlgpf8FoMcMBSKFIioTgiDP+5Q/O9M+HYHeSocm56sjA7qoFnX3tR+eEI4UqW1HaBW/XmWqnPWnAwwtOD89nQ4FQoJBWOoEfqmJgoki6syy+43eawtfdg27rXLqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FbhM8SH1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76145C4CEC6;
	Thu, 19 Sep 2024 13:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726753329;
	bh=Ddg68ZWVidcqPqMiyOPkT4CJlaowbdtqhlHc9z5kbD8=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=FbhM8SH10VlPVNRQcY/DjuP42fECdCKIJGh5BhrPQxfHrOOUipi6XofvcQcU5A7y5
	 9PqgtmvblaM/DOaH39C4LiTKllBWSS6i2qLvP9ZTtGXKH8PhF4kqOZ64IueKaHz/nN
	 0P4mqhfyWVQFZqNIs5Uo2KAQ8kZpoTGJ6al6E8xoiKQ/W7YTr9u+ZOpM8b9Ic4Cx+1
	 /zEC9vvX//Z2/AMDy8eNRSWw6AE1+inMEuAEXzSLH7hODPuxK+fJLXrIQFzdZVEKi4
	 KG5E3lOOo1koM9q1R2wupKs/7GxCtf7n3LRyfQ1aoA7M+BJxxhKxDCb1J7TfkeNXye
	 BXK3rCMbuS2SA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Sep 2024 16:42:05 +0300
Message-Id: <D4AAYUVJV9D1.J8XJ05EIL9ZL@kernel.org>
Cc: <jgg@ziepe.ca>, <linux-integrity@vger.kernel.org>,
 <apronin@chromium.org>, <jettrink@chromium.org>, <gwendal@chromium.org>,
 <chrome-platform@lists.linux.dev>
Subject: Re: [PATCH] MAINTAINERS: Add Google Security Chip entry
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: <tzungbi@kernel.org>, <peterhuewe@gmx.de>
X-Mailer: aerc 0.18.2
References: <20240919055754.2036555-1-tzungbi@kernel.org>
In-Reply-To: <20240919055754.2036555-1-tzungbi@kernel.org>

On Thu Sep 19, 2024 at 8:57 AM EEST, tzungbi wrote:
> From: Tzung-Bi Shih <tzungbi@kernel.org>
>
> These are Google Security Chip drivers and are mostly used for ChromeOS
> platforms.  Add a new entry for them.
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8a76c256229c..07dc83e01216 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9593,6 +9593,15 @@ S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/lin=
ux.git
>  F:	drivers/firmware/google/
> =20
> +GOOGLE SECURITY CHIP DRIVERS
> +M:	Tzung-Bi Shih <tzungbi@kernel.org>
> +R:	Andrey Pronin <apronin@chromium.org>
> +L:	chrome-platform@lists.linux.dev
> +S:	Maintained
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/lin=
ux.git
> +F:	Documentation/devicetree/bindings/tpm/google,cr50.yaml
> +F:	drivers/char/tpm/*cr50*
> +
>  GOOGLE TENSOR SoC SUPPORT
>  M:	Peter Griffin <peter.griffin@linaro.org>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)

1. From now I expect either give reviewed-by. That helps also with my
   decision so I welcome that of course.
2. In the end I pick drivers/char/tpm changes. This not because I would
   want to cr50 specific changes but because I want to make sure that
   they fit to the context.

With those constraints:

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

