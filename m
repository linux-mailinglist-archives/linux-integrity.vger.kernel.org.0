Return-Path: <linux-integrity+bounces-5135-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AC0A54EB4
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Mar 2025 16:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA668174418
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Mar 2025 15:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5D68624B;
	Thu,  6 Mar 2025 15:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="GLDvl20f"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E6CD299
	for <linux-integrity@vger.kernel.org>; Thu,  6 Mar 2025 15:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741274152; cv=none; b=qpZ2IL1pUd3qi5bvmdfvlpD1HEhEkQnJIXoOcMx9QvbNzif9pphH5Z1sGA/Kfu/hwl+A0QG5DLvX7DLVwEH/BL6lN3uwP8vYLvvx3Rrv+xiyLqDAFfeF1kf30sQtDhzv+Mh7T868NNQWvpi03KBoaVWgJBwEvhXrM5MrQXwZbS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741274152; c=relaxed/simple;
	bh=lCORjU99Y+Jeb/STd7W/edkYjNgZmfQ2s/RSwaQxiu0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=X7s8Bal1U01crxQXiBOjK+PJo65EjCZUBM40e1BrdxNDvXR8FDVM3pVtkw8HOQLfE2ZNZg52Yj87V8DOhSs4gU7vQYwVdLBw3sZsTRNuj03f2gyGD/MAlD4vuILLQpI5/Sec73HIaqtlaY9/B4KckunufbmJFMLxn7vOOfG1oGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=GLDvl20f; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:
	Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=Ki9wjn5lU16Oyi+Hse/wmDbrXLWfB2WYpeM11ko0fE0=; b=G
	LDvl20fXv6lFJjQGSeKipHFDRD8s2qmSt+YOR3TA50XjJMABg5cNbVuFJvlRtvPdnVqZXw3N1WYoY
	So3ibxscqmZn9upymPTiXiyI0V8Zf7kDEgPp7ahDL3h9wYJcpmMOuiYiaDZHcBhXSPKvh0B8HXsny
	9DHSkahaZROIDWXJjjNKbz9WFokX4XHHHAQMLywQUxITMgl/zo1+ttpWQmdumxv7W5MTAfC8yzMga
	FaysQ5toyrOTAeLEXWfiHhQ1VGA3Cm3NNoBidqGw2kuRfbEJwI6hEG3AryX1c90YQNOsukRwx5PxP
	wTOO7nKuFebkXpp7aRjtuCHvs9JA99OLA==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1tqCwl-00C0yN-0U;
	Thu, 06 Mar 2025 15:15:39 +0000
Date: Thu, 6 Mar 2025 15:15:39 +0000
From: Jonathan McDowell <noodles@earth.li>
To: James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org
Subject: Unbalanced TPM2 HMAC session calls
Message-ID: <Z8m8G0RfiRyYGH_t@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

We're seeing a lot of:

tpm tpm0: auth session is active

messages in our logs. This is emitted (once per boot) by 
tpm2_start_auth_session() if the auth sessions is already active when it 
is called.

Investigating I think this is because tpm2_pcr_extend() calls 
tpm_buf_append_hmac_session() which sets TPM2_SA_CONTINUE_SESSION so 
tpm_buf_check_hmac_response() does not cleanup the auth session, but 
then doesn't call tpm2_end_auth_session().

Looking at tpm2_get_random() it uses TPM2_SA_CONTINUE_SESSION but *also* 
cleans up with tpm2_end_auth_session().

I'd be sending a patch proposing the addition of tpm2_end_auth_session() 
to the end of tpm2_pcr_extend() but I recall a bunch of discussion 
about trying to cache the HMAC session to improve IMA performance, so I 
don't know if perhaps we should be dropping the warning instead?

(As an aside, I'm not clear dropping the warning is enough, as I can't 
see where the session otherwise gets cleaned up other than by accident 
when the RNG tries to get more randomness.)

J.

-- 
I've got a trigger inside.

