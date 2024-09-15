Return-Path: <linux-integrity+bounces-3602-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D837C979802
	for <lists+linux-integrity@lfdr.de>; Sun, 15 Sep 2024 20:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 652FE1F218A1
	for <lists+linux-integrity@lfdr.de>; Sun, 15 Sep 2024 18:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6301DA21;
	Sun, 15 Sep 2024 18:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihIhkayP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C4617C91;
	Sun, 15 Sep 2024 18:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726423494; cv=none; b=eU38iI5HUpVY/0ejUhQKLeyq3W3sW0nlWeAkYdJRMFoaxdl+loyhsb8er4DBbQdzBndEUIEHSn4pJeDcOdutP+UKNF6WJcbxyITASsJOTpuAOqzriB37to74xeVVzHjxfS4xdZSY3pTA5kJXHDQkuTvx4JHyKUq7DPOFvyOlIIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726423494; c=relaxed/simple;
	bh=VAH4hJYC4Wa2Y9sPOtgVu9TelqHBxDHVEfXez1m/n/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dTZi1ekudDDjQOpUQ3bt/LX0Zo3CQ+830g9aQWX7OaOUvyBD+CdHhixWokbtLE3zGE9QOz8SjX+WUOlX1dbHxbEy71PeLLJUv4jpnFVGux54FskTDs8IMlYvo1bVjXS6s1lEgVBoLuCE97cU0H0O+Ey4b5RJORcFIZNHOK/9+fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihIhkayP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B88DC4CEC3;
	Sun, 15 Sep 2024 18:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726423493;
	bh=VAH4hJYC4Wa2Y9sPOtgVu9TelqHBxDHVEfXez1m/n/I=;
	h=From:To:Cc:Subject:Date:From;
	b=ihIhkayP4EkDFXIhNr5jhXIpgWDfKcUak995Es+RNEbdqnowblUujFjgfbNvcdX+K
	 fOZDD3A2ISvcoflSu0Fvlnr4Yr/U6YpgEd0td4XI+ItFLzvWaZESOF5cKqfplucLKh
	 +UZVCwfwCWMWWR9RRZXoMyFxkj+p8AwY/0Sn88BzTCr/WYBkhQk9AlK9GRpwPPDFsQ
	 XU5dwex2hK+kOxmVNzf89uaZOjC+5rM3CH91ZB+7Bxvp+Z9zW1npldRA1iC6ITVfx5
	 3ZwPkDZ6GW/xo5kgWSqxjxWXhJQjojwoeKCWWqCdiH7RhPLtwDDFjEBU2wp5LptuJ8
	 Erf5M5jK0NRgw==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com,
	roberto.sassu@huawei.com,
	mapengyu@gmail.com,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/4] tpm: lazy flush for the session null key
Date: Sun, 15 Sep 2024 21:04:42 +0300
Message-ID: <20240915180448.2030115-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no load and flush the null key for every transaction. It only
needs to be flushed when user space accesses TPM. This postpones the
flush up to that point.

The goal is to take the first step addressing [1]. Other performance
improvements are needed too but this is the most obvious one and
easiest to address.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=219229

Jarkko Sakkinen (4):
  tpm: remove file header documentation from tpm2-sessions.c
  tpm: address tpm2_create_null_primary() return value
  tpm: address tpm2_create_primary() failure
  tpm: flush the session null key only when required

 drivers/char/tpm/tpm-chip.c       |  13 ++++
 drivers/char/tpm/tpm-dev-common.c |   7 ++
 drivers/char/tpm/tpm-interface.c  |   9 ++-
 drivers/char/tpm/tpm2-cmd.c       |   3 +
 drivers/char/tpm/tpm2-sessions.c  | 115 ++++++++++--------------------
 include/linux/tpm.h               |   2 +
 6 files changed, 68 insertions(+), 81 deletions(-)

-- 
2.46.0


