Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF78A13939C
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Jan 2020 15:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgAMOX0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Jan 2020 09:23:26 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34476 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726277AbgAMOXZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Jan 2020 09:23:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578925404;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=YEhK+4kl7cQbrvushadVJymcfezZsR6Q8L9f9dsnLPw=;
        b=MLCKeetfd2G6APAhkJ6ze0VBpNIcq+uFRovGwvyxVKXo++tBbJFWGQIJrBdtWO+LmWt9Zx
        aJkQ5cRVyibLaOkS4VC2hd/u3b3c99CXdVwsYEIJBKaFLVTSXpY737IWUxoIpNI39Uwz6F
        ndPAhAUqzfNH8qWrE/GCqXJoPlHGeeY=
Received: from mail-yw1-f70.google.com (mail-yw1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-tGeguE9vOPiKLOu-XAWbEA-1; Mon, 13 Jan 2020 09:23:23 -0500
X-MC-Unique: tGeguE9vOPiKLOu-XAWbEA-1
Received: by mail-yw1-f70.google.com with SMTP id u199so11764267ywc.10
        for <linux-integrity@vger.kernel.org>; Mon, 13 Jan 2020 06:23:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=YEhK+4kl7cQbrvushadVJymcfezZsR6Q8L9f9dsnLPw=;
        b=CjngNbI+U8IX4uEh0oVJ6fZ7Ofsp3qB01bjHSgSvqC9z0uKMzYg8DkyDzteJKzUoIq
         ACkV+TVAlKm6HnqLAIgRYk00GUxqY2+rDftr6+Zy+ESzpP3v9tWUZycYkADRlBq3rfsZ
         R49qfOIfVoJmdUGLjWOqyr9SeqqCOAUwD4ZuadJgHx4z8bbpi0tB5+CPzsR5pvjnyjY2
         cAjzQFYvJut1tXCGzlzg9U+2eTDMQiT7yjgh8jU62HlO2pKzdymazy0u51U2KIt55syu
         wr4z1JXtoJ5VGJe5jRSUqqWcE6V5q3ZxiNW1hh6uPdHkVwz+kGR5feZfRXXV5d0sQPoO
         OJhw==
X-Gm-Message-State: APjAAAWwB/H4UUrS5xDtEn+jl2knIE146W9XvAuqlt6mYe34AeV+hDKw
        hIg5dz+o3J74srTnlwbnxN4ggNfDloGoumOD/GRv50IrjTIUE89zmoSaJy49l4KjW2eQ6B3Xp2m
        b6b9GJ/4XIdpyY+4x5IQvPlIlTu0P
X-Received: by 2002:a5b:881:: with SMTP id e1mr12665858ybq.81.1578925402546;
        Mon, 13 Jan 2020 06:23:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqz8Cd0MzX2M/xO0EjxnCiOEj6aO2wKBf8SdQtc0aBJG7TXuNVUYV1Z2iceSZ1vUtJjado4Q3A==
X-Received: by 2002:a5b:881:: with SMTP id e1mr12665837ybq.81.1578925402251;
        Mon, 13 Jan 2020 06:23:22 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id t140sm5074469ywe.28.2020.01.13.06.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 06:23:21 -0800 (PST)
Date:   Mon, 13 Jan 2020 07:23:19 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm: Update mailing list contact information in
 sysfs-class-tpm
Message-ID: <20200113142319.r2gfnmw254owobue@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
References: <20191025193628.31004-1-jsnitsel@redhat.com>
 <20191028205338.GI8279@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20191028205338.GI8279@linux.intel.com>
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

Hi Jarkko,

Should we put this into 5.6 as well?

Regards,
Jerry

