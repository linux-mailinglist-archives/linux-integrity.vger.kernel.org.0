Return-Path: <linux-integrity+bounces-6853-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE10DB2758A
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Aug 2025 04:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1D825C4FDE
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Aug 2025 02:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360591C1F22;
	Fri, 15 Aug 2025 02:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8/G8O3N"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACF817A305;
	Fri, 15 Aug 2025 02:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755224409; cv=none; b=W3RN1ppbj6rqIBEpqmDUtmE7uzcHrjwk5SrHTNeS76KY85lAYtBYXcKDSSrd7lcbJtKU0QFZTXQsAFPzcX80mFZqZEdObH9vo7qqU9Y1xczkGq2YH5/5QeTqP2zHrveTCRun/4uYCqF0dmCs6x/Jmwm01fyjsSvzx2plaoQBdt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755224409; c=relaxed/simple;
	bh=IfAmTSII9FkrbkxbpEFQlBO8qqOxaldoxNjA+09jsw0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Og7VyIv9Y9AJfBs6xejLhLaB5qTE4CYEzBxsDa+kN5qLY0OVYlpieh/2wEQmGTKt2+nd3eUDeTOvYSwnXbODEZW++IO6Wyeqd5Z0t2JGn/CdRWL4hQ3SI0dEHbDZymGgAl8YmS4UqYLCXHuRH5fCqOY9y+4uE/ua3Jbo8U8pRl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8/G8O3N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E93AC4CEF1;
	Fri, 15 Aug 2025 02:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755224408;
	bh=IfAmTSII9FkrbkxbpEFQlBO8qqOxaldoxNjA+09jsw0=;
	h=From:To:Cc:Subject:Date:From;
	b=T8/G8O3NDX/2TYhMkd7Ny/YvdQ1hYcOZtAIbF8c58249EaczKSPbgp9ZX1BSLVwDQ
	 wNDjuHkGgMRMjMYtO6IuQZA1IUGwUKIK2BVKoLb2wKBOseeNasUMHqZx3PZf0dmoFH
	 EHAlEMZfnibphgPXMG/u8vFQP2FEhjStqP+/gPH2SDoQWuYa3imqQNfE8yqtK8Gw6b
	 e7/ywlF8M0vRwLbgL2mykQ1QkEVLHmKWBRmXgxfvCNgrYfDt4dEdBIPbe9nmbhy8Lz
	 9w6eJYpHqzOCJEtKA/Svq8BXthBZk7/CZgQyjKJQzVOxmwMzwKwgY/ptBo2Lm/VVUx
	 D6tyuZOdlUJGw==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-integrity@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>,
	linux-crypto@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 0/2] Convert lib/digsig.c to SHA-1 library
Date: Thu, 14 Aug 2025 19:17:31 -0700
Message-ID: <20250815021733.25689-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series converts lib/digsig.c to use the SHA-1 library API.

Please consider taking this series through the integrity tree.

Eric Biggers (2):
  integrity: Select CRYPTO from INTEGRITY_ASYMMETRIC_KEYS
  lib/digsig: Use SHA-1 library instead of crypto_shash

 lib/Kconfig                |  3 +--
 lib/digsig.c               | 46 +++++---------------------------------
 security/integrity/Kconfig |  1 +
 3 files changed, 8 insertions(+), 42 deletions(-)

base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.50.1


