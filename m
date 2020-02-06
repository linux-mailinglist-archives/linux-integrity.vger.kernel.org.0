Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75BD9154C0D
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Feb 2020 20:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgBFTWq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 6 Feb 2020 14:22:46 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35949 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727923AbgBFTWp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 Feb 2020 14:22:45 -0500
Received: by mail-pg1-f193.google.com with SMTP id k3so3233364pgc.3
        for <linux-integrity@vger.kernel.org>; Thu, 06 Feb 2020 11:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:cc:to:from:user-agent:date;
        bh=77zEgP4+kvjzTDiKwzePB4Pg1qZYvQ9rh1jBzop1Cfo=;
        b=UDJWWrKmyAku8utbdUF/Ir+N8v/ND76ypMceKgDu7fS4zXsNrq+sw4xiy6otRjvqNn
         +ttDwYybEZg2A7GqfJwbjc3aV4UiF67/sYc9c/93Oy3JDYmIE5yKua4ATLykNnIjQh4k
         81KgxcGBkJ3hKV6ws5TtT7IUmIpU437MTbHJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:cc:to:from
         :user-agent:date;
        bh=77zEgP4+kvjzTDiKwzePB4Pg1qZYvQ9rh1jBzop1Cfo=;
        b=pz5h3Ei8gAvDfnAEH6jh4Jqw4Vu0wOTpbQHlFjQ0Mf7xoJ/9FiD7SUz+t7oasywmiH
         F+GkzTfEF8RnCVsWl/JbrJ6aDy7K3QjCk3IaYeA6GsmZd74btKOSQPZSWspRKiRbL6Uz
         UZ3rMS3eA/LZkVk1XuV1KuoITBzOtRbuISj8JlnZ6uQGVza+Z5aRPo2U6Ps2lEH8VWAl
         7wJgmT5EdDK9StkONHh9K8oMHCMMSPJjJr1J5fBneOkf6M8LzFbXrfBGMQ9CKndXjaZ7
         7TlF3CE0w3ICyGZpqCrHBNxlCyHJeWiBg6ZJHf66ZhGTtPolTBDFga6iCNX+Aeb0g1n3
         +JMw==
X-Gm-Message-State: APjAAAVjaxrXzi4xsZxzYjeMMR1zW0xlxDKaGYq0SYlpkWAsWjLFB5XV
        bEqYHdbgOarwqDOwZwGZ9JM0KA==
X-Google-Smtp-Source: APXvYqx15GV6iXPlg6VEgBbt5XLtoCLhj9G1kgJ4mJJ+PUEVWX9tF8+ZXmb7/HjMq5ZD3BXw5H8Yng==
X-Received: by 2002:a63:1f54:: with SMTP id q20mr5053928pgm.400.1581016965253;
        Thu, 06 Feb 2020 11:22:45 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id e1sm171231pfl.98.2020.02.06.11.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 11:22:44 -0800 (PST)
Message-ID: <5e3c6784.1c69fb81.34ded.0a42@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200205203818.4679-1-jarkko.sakkinen@linux.intel.com>
References: <20200205203818.4679-1-jarkko.sakkinen@linux.intel.com>
Subject: Re: [PATCH] tpm: Revert tpm_tis_spi_mod.ko to tpm_tis_spi.ko.
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Andrey Pronin <apronin@chromium.org>, stable@vger.kernel.org,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Thu, 06 Feb 2020 11:22:44 -0800
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Quoting Jarkko Sakkinen (2020-02-05 12:38:18)
> Revert tpm_tis_spi_mod.ko back to tpm_tis_spi.ko as the rename could break
> the build script. This can be achieved by renaming tpm_tis_spi.c as

Do you mean userspace scripts?

> tpm_tis_spi_main.c. Then tpm_tis_spi-y can be used inside the makefile.
>=20
> Cc: Andrey Pronin <apronin@chromium.org>
> Cc: Stephen Boyd <swboyd@chromium.org>
> Cc: stable@vger.kernel.org
> Fixes: 797c0113c9a4 ("tpm: tpm_tis_spi: Support cr50 devices")
> Reported-by: Alexander Steffen <Alexander.Steffen@infineon.com>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

