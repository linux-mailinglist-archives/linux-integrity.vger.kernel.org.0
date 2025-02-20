Return-Path: <linux-integrity+bounces-4946-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B66CDA3E4C4
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 20:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B83BC3B4968
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 19:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D266213248;
	Thu, 20 Feb 2025 19:09:46 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8671ADC6F;
	Thu, 20 Feb 2025 19:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740078585; cv=none; b=HP5rWTWbKF4zlj7F1SuBz2iEnVXMki5CnMbk7HSQgQL9I4uJ+zR3CGYGoDsq/wu7FBjZKHwcgzVqGldtMMeCTzrhuctDVwxeafGmDMllDdnA9Zeiof4XMBmXwpQe9NnoO+zkWVd5nRWBPYIvV15aWYckW/b4IZApYMo0ig5msc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740078585; c=relaxed/simple;
	bh=qWXor6ko4jwGZsLZDFXIJmhO23hpSb+mieYweZchsmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NyGT2JWnyExliE5B+cC+lyZQzdfC7vs/P7L9spU28TeaS6WF52XsiMV+hBgitGIqY3T9pROD6Hc6F3qai2RuS6BJv9Sc1nTZTkjTthRMY1qq7Oq9+iiWDyfX0B2EiBNEsDJGT0gwaw7R2FLZ70ogWmT8RUPa7BgzJPVXGBQzpL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af4e3.dynamic.kabel-deutschland.de [95.90.244.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 348A361E6479C;
	Thu, 20 Feb 2025 20:09:30 +0100 (CET)
Message-ID: <285e81d8-dd07-4075-9c09-0e2b4e59aeae@molgen.mpg.de>
Date: Thu, 20 Feb 2025 20:09:29 +0100
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/5] tpm_crb: clean-up and refactor check for idle
 support
To: Stuart Yoder <stuart.yoder@arm.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org,
 peterhuewe@gmx.de, jgg@ziepe.ca, sudeep.holla@arm.com, rafael@kernel.org,
 lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250219201014.174344-1-stuart.yoder@arm.com>
 <20250219201014.174344-3-stuart.yoder@arm.com> <Z7b2BlllE6HVIZNN@kernel.org>
 <7c913fc0-0f2c-4327-99ee-510bdff8a537@arm.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <7c913fc0-0f2c-4327-99ee-510bdff8a537@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Stuart,


Thank you for the patch. Should you respin, you could spell *clean up* 
in the summary/title with a space.

The diff looks good.


Kind regards,

Paul

