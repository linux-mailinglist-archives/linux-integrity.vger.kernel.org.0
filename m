Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3E2145CD4
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Jan 2020 21:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgAVUFC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Jan 2020 15:05:02 -0500
Received: from linux.microsoft.com ([13.77.154.182]:53926 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgAVUFC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Jan 2020 15:05:02 -0500
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2A0F12007679;
        Wed, 22 Jan 2020 12:05:01 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2A0F12007679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1579723501;
        bh=VkKFVv9AeIsNp0khDafTW1BBobp2dQUzk7DlpNA1WeQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=kvZOepP7QvtQdOnbBQxDFcMif1b5f1bXdbkUpI62NFjS1vJzbgoNav7quPt5+PvCM
         E1RBM9/F1G24thc4mbYQZTneeFzbi6Y5by5Z6KvbX8cPx9irNGL6JPw2/YtHoLzsuq
         Ry8jFQbuFCzuctr5yfKrlpKjOOEbNsv/Bp4FXCio=
Subject: Re: [PATCH] IMA: Turn IMA_MEASURE_ASYMMETRIC_KEYS off by default
To:     Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, linux-kernel@vger.kernel.org
References: <20200121171302.4935-1-nramas@linux.microsoft.com>
 <1579628090.3390.28.camel@HansenPartnership.com>
 <1579634035.5125.311.camel@linux.ibm.com>
 <1579636351.3390.35.camel@HansenPartnership.com>
 <ac6c559e-2d68-afcb-d316-6ac49a570831@linux.microsoft.com>
 <1579723379.5182.130.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <fa7ec770-6552-7538-7393-c23410b3a1ba@linux.microsoft.com>
Date:   Wed, 22 Jan 2020 12:05:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1579723379.5182.130.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 1/22/20 12:02 PM, Mimi Zohar wrote:

> 
> Thanks, Lakshmi.  This requires moving the code around.  Instead of
> doing this on the current code base, I suggest posting a v9 version of
> the entire "IMA: Deferred measurement of keys".
> 
> I suggest making the switch from spinlock to mutex, as you had it
> originally, before posting v9.  The commit history will then be a lot
> cleaner.
> 
> thanks,
> 
> Mimi
> 

Sure Mimi - I'll post an update to the patch set shortly.

thanks,
  -lakshmi
