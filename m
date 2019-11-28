Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2011810C14A
	for <lists+linux-integrity@lfdr.de>; Thu, 28 Nov 2019 02:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfK1BJu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 Nov 2019 20:09:50 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46351 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727088AbfK1BJu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Nov 2019 20:09:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574903389;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gToFrwAF3Uy6k7hO1WWqHDn6U7gZbrdQcmuYWTaqI8A=;
        b=QOiQEOqF4nweGzwPtDGttJO6rDa3VeWiZ+xV3rquXirlcfvGG7EwhmANtA0BfAzrinjPQm
        SNfve2z10VKowVisPSQyAVg3nHLtAaKrkXd16FSg7DQw7Q2gVcNRFsWjahX8dXT5joQQbn
        uENSCvQqttFBMAGdaB6MS+egXsJR6hM=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-Him3DtiEPPqh8FUL6cPvKg-1; Wed, 27 Nov 2019 20:09:45 -0500
Received: by mail-pg1-f200.google.com with SMTP id w9so13734271pgl.1
        for <linux-integrity@vger.kernel.org>; Wed, 27 Nov 2019 17:09:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=gToFrwAF3Uy6k7hO1WWqHDn6U7gZbrdQcmuYWTaqI8A=;
        b=NJ0aQDTbukFoIXivYzNFf8E7JHg3XDDvNzfy2ry4SWeV7GzOXMkQegpkKTPctOd4Mq
         tc83Xz1f5TyrSM0HH1HP1T5nOZQOk4WMi57DR5Ezv1AbqQBW3cnehEIwgU7SQDbsdp7k
         4FyMj8AZ738OhRQBzuHGHcRyUUC6enmIP/iSMpX/ZsbNdIbBagsJGM7k+xZenVz9Y32d
         2jF/whDZnCjAayA9FAzrUbua7fOri/I/178xYdG9Dkiyo4B2ipOBKbWJHadSlZToMm4V
         aoco5vTY0r9fT2FtZKrmEjShug9dcXF6vQAm4zIdhwYfZjH54g0UHQhELEDQFti2SRbj
         9WsQ==
X-Gm-Message-State: APjAAAV4nlX9UYMcaprV9tZMn45nvbk0QIH35iexBhz/p7Bvg0wm3bi3
        ukpPOS3jku6jcwJ1r85Gwy8eaLeO+v55a2EqpQ4T3DDptHIHMeFFCXtsxvRoiyeVTOLlyXcQJF0
        z2Go+DhqQlwbQgp8wTgcTJeIIBg+h
X-Received: by 2002:a17:902:bb83:: with SMTP id m3mr6896862pls.94.1574903384574;
        Wed, 27 Nov 2019 17:09:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqyIvzsNym80Q9Lwzet1IKxQ6KC5wqL0VT0ocnGy4kM0wenhkNMfOac8XHuBRaPjQdgzX7ZxoA==
X-Received: by 2002:a17:902:bb83:: with SMTP id m3mr6896839pls.94.1574903384223;
        Wed, 27 Nov 2019 17:09:44 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id v63sm18029926pfb.181.2019.11.27.17.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 17:09:43 -0800 (PST)
Date:   Wed, 27 Nov 2019 18:09:42 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm: Update mailing list contact information in
 sysfs-class-tpm
Message-ID: <20191128010942.ysfkztficovmdl42@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
References: <20191025193628.31004-1-jsnitsel@redhat.com>
 <20191028205338.GI8279@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191028205338.GI8279@linux.intel.com>
X-MC-Unique: Him3DtiEPPqh8FUL6cPvKg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon Oct 28 19, Jarkko Sakkinen wrote:
>On Fri, Oct 25, 2019 at 12:36:28PM -0700, Jerry Snitselaar wrote:
>> All of the entries in Documentation/ABI/stable/sysfs-class-tpm
>> point to the old tpmdd-devel mailing list. This patch
>> updates the entries to point to linux-intergrity.
>>
>> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>> Cc: Peter Huewe <peterhuewe@gmx.de>
>> Cc: Jason Gunthorpe <jgg@ziepe.ca>
>> Cc: linux-integrity@vger.kernel.org
>> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
>
>Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>
>/Jarkko

Should this go into your next branch?

