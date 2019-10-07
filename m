Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B08FCE655
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Oct 2019 17:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbfJGPDQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 7 Oct 2019 11:03:16 -0400
Received: from linux.microsoft.com ([13.77.154.182]:50330 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbfJGPDQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 Oct 2019 11:03:16 -0400
Received: from [10.200.157.26] (unknown [131.107.147.154])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0176020B71C6;
        Mon,  7 Oct 2019 08:03:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0176020B71C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1570460596;
        bh=3UNgHczRc93rsHEBArN7oW1VK8U/knTQGdJtQ9X0udk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=kjT52YlScVFZYoE2Jg9J3Sa38C1SOIOiTuNbARiN3aNA1TJ22TbyY5Yqr2EY6PaGd
         T8S7ABB/YXQJQrhIHtSqpFkFQTrcLhhh8FMT3h0i/1KnuMzvCCdBGOKQOON013kfHH
         UDc99R7Zb2tsMesEZwzf/JP/FIq6padDavFilI+U=
Subject: Re: [PATCH 0/1] KEYS: Measure keys in trusted keyring
To:     Mimi Zohar <zohar@linux.ibm.com>, Sasha Levin <sashal@kernel.org>
Cc:     linux-integrity@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>,
        jamorris@linux.microsoft.com, kgoldman@us.ibm.com,
        "Wiseman, Monty (GE Global Research, US)" <monty.wiseman@ge.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Greg KH <gregkh@linuxfoundation.org>
References: <20190828002735.31025-1-nramas@linux.microsoft.com>
 <1567041083.6115.133.camel@linux.ibm.com>
 <ec8d7cd5-a83a-c344-eaa6-9bd2cef08772@linux.microsoft.com>
 <1567190507.10024.134.camel@linux.ibm.com>
 <2cd27f52-1029-bcea-c73b-7d3d002cf030@linux.microsoft.com>
 <1568035881.4614.347.camel@linux.ibm.com> <20190919131851.GA8171@sasha-vm>
 <1568913178.4733.89.camel@linux.ibm.com>
 <1dfc7a83-3fcb-1356-958e-2afb7c6f1285@linux.microsoft.com>
 <1570219032.5046.101.camel@linux.ibm.com>
 <868f6b82-7b43-5e27-0738-f9d09e765c59@linux.microsoft.com>
 <1570226287.5046.114.camel@linux.ibm.com>
 <382dfa7b-a5f9-01e3-0624-9ecd526557bb@linux.microsoft.com>
 <1570367871.5046.161.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <59a7386d-5cb6-110a-7261-072f9c2c80a8@linux.microsoft.com>
Date:   Mon, 7 Oct 2019 08:03:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1570367871.5046.161.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 10/6/19 6:17 AM, Mimi Zohar wrote:

> As defining an early IMA workqueue and measuring keys are independent
> of each other, they should be posted, reviewed, and upstreamed as
> separate patch sets.
> 
> Mimi
> 

Yes - I'll create separate patch sets for those changes.

thanks,
  -lakshmi


