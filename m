Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2C745735
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Jun 2019 10:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfFNIQ1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 14 Jun 2019 04:16:27 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:45104 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfFNIQ1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 14 Jun 2019 04:16:27 -0400
Received: by mail-lf1-f42.google.com with SMTP id u10so1069558lfm.12
        for <linux-integrity@vger.kernel.org>; Fri, 14 Jun 2019 01:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sz21dcEmUnt78YNFfm6F9rMky982RcdT6miE7Kwy+xQ=;
        b=cgNaSFKwKYmVfImDO2DRLbyekomRK9qHKelIPfrEQAtqGlD1M55ojIBI7PTJXK6ig0
         VlSjky6WaPqSI113zdWaJbUUGusnixgE68yKeX0SUfDFX1Td0a8SkmoodjzeNEkMYBTe
         /iBHx4Smi1pAPuNhZiBPk2XbdRhx/Pp8pYRVXPdOv2IxSK1Xy2yIvxP1ZrJHm5CFjw4q
         ePBGvlF5iluLyr+9Jyu9BuoJDyoyVMZlKvYs/45e1ppUV5/2FZJO/uvy2N4J009is8qu
         BjaIGtSadmPLLgk2zxF/2WNL9qP65CHoWbydut0H7Nrt7w9gWhrmTAUWbaqfRnsQKfk3
         WiCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sz21dcEmUnt78YNFfm6F9rMky982RcdT6miE7Kwy+xQ=;
        b=Vqs3Ui+QKgTkn7tpRdI7Plz7P2OZsCqIS4Af6/O6iC+YAWsBSUQoSy11R6FjElXJc9
         hbStYNCset4gSA9CofIBIMu1Nk0zzG5YKliu8ty6isTYkEtYkZZ+v91BSLKCKtJxawbr
         IF6GTW3ZxNftSeNoXc+6Ye5UMfRKHTCorfxxuXnelvOGUsnPbHfyDRUeRWZ3Gk6WcuJM
         FUqKn8QXTKTZ02jfJvqBewC3qw9S65rP56NwieFWAV4YbXJcEQYQPm7T2n/c6WHExjmp
         uarhur6mPA6WT6XjXMs8+2ASYbUXtV6sIl4Uls8RjYNv59c5VIB/pFMP915HetVvexq/
         H8BQ==
X-Gm-Message-State: APjAAAVRpo8Tn1cFPYjfj59Gnh9em+im/AIZ+KUItqK1yTCPaEvg7XLr
        E0Jx3tVVhvUiW+X9kzmkoE8Nhg==
X-Google-Smtp-Source: APXvYqz2SFwlCts58NJ9uhwjuLDS0BZ40ErMRTVyj9BXE6UW3BuzWyga/5vhM3jc6xoSbw4tyw5ZYA==
X-Received: by 2002:ac2:418f:: with SMTP id z15mr18332522lfh.177.1560500184883;
        Fri, 14 Jun 2019 01:16:24 -0700 (PDT)
Received: from jax.lan (81-236-179-152-no272.tbcn.telia.com. [81.236.179.152])
        by smtp.gmail.com with ESMTPSA id q13sm357761lfk.65.2019.06.14.01.16.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 01:16:24 -0700 (PDT)
Date:   Fri, 14 Jun 2019 10:16:20 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, corbet@lwn.net,
        dhowells@redhat.com, jejb@linux.ibm.com,
        jarkko.sakkinen@linux.intel.com, zohar@linux.ibm.com,
        jmorris@namei.org, serge@hallyn.com, ard.biesheuvel@linaro.org,
        daniel.thompson@linaro.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org
Subject: Re: [RFC 2/7] tee: enable support to register kernel memory
Message-ID: <20190614081619.GB9347@jax.lan>
References: <1560421833-27414-1-git-send-email-sumit.garg@linaro.org>
 <1560421833-27414-3-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1560421833-27414-3-git-send-email-sumit.garg@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 13, 2019 at 04:00:28PM +0530, Sumit Garg wrote:
> Enable support to register kernel memory reference with TEE. This change
> will allow TEE bus drivers to register memory references.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>


Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>

Thanks,
Jens
