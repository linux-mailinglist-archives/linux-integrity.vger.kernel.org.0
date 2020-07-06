Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F043C216139
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jul 2020 00:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgGFWCg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Jul 2020 18:02:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24308 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725892AbgGFWCf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Jul 2020 18:02:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594072954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TkXhzKLqTF0E87EA7fDsRKyQKfMvqiBc3obNNpfDHJg=;
        b=DucSklgwx+OqC4+NqowIsedcJHaa0jtAzzX3OJfVaSIm+AKkk/nqckfsBimvAPPptFu4Zj
        Vus9mVVzd+OKrOQFbIDAoqJ3gAUzFbgDMX2HvSGFcgJsYI1pac4cWQp1m7c9r/zH+EeSdx
        2UPBtgxj5wKO8qET/9E7Um9Vnbk4V8I=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-e17uoX_bN0qoqtpbYDc-Cw-1; Mon, 06 Jul 2020 18:02:17 -0400
X-MC-Unique: e17uoX_bN0qoqtpbYDc-Cw-1
Received: by mail-qt1-f200.google.com with SMTP id k9so3468665qth.17
        for <linux-integrity@vger.kernel.org>; Mon, 06 Jul 2020 15:02:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=TkXhzKLqTF0E87EA7fDsRKyQKfMvqiBc3obNNpfDHJg=;
        b=Yntsfx/MydSwYPWBQ0W+LGprnIE10o/JskreKPF6bsT1cVzO5MDwiyHvGSc/VTVNv6
         tb6KTr6Js3hUYxYXgzYnYohUxP1elcp9I5gU4woG0cBl1j+RxOYBWhLMXYrlD4aEdbb5
         kCR8u2zrGMfVl9K7WhvW96gyWa9QcDD29RUXHRAdZuNGukbqv3fKd0dVBva65Zk771Ar
         3Xb/pHTRstS9TzBu9SdySxHyGocvhxVATC6qPe9R82LDD+zZt4+o6l1s4Ga3+2J06c6K
         HdLXEAAlXyQfYviz2Qd4WdamfhhfdMuOUbztXZLX3xZLgKoAsK5dGIwlHSJsy5BkUEE3
         YDyg==
X-Gm-Message-State: AOAM5321cPWKJyKHt64Jf4A3ajgs4tbPdFxhchwALZwXuaXQ/HOTw58H
        4PJgyR5cWmSfCIKqvx+c47P3YKUyW6KHcQtVl+M3awZ0O+b7MVLo/+yQdMDP5lSvAEB9HhRwTtT
        6wVj7aQ+sC1gyXJdO50BlK5IDyljR
X-Received: by 2002:ae9:f002:: with SMTP id l2mr39136111qkg.437.1594072936807;
        Mon, 06 Jul 2020 15:02:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRP3z9E0tdvX8t39vt7/9u4f1ETvgBsRpRz2CaH0flMAo/xsbjQX5JZ47vfESsqw8doha+rA==
X-Received: by 2002:ae9:f002:: with SMTP id l2mr39136066qkg.437.1594072936430;
        Mon, 06 Jul 2020 15:02:16 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id a3sm20911329qkf.131.2020.07.06.15.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 15:02:15 -0700 (PDT)
References: <20200706181953.3592084-1-stefanb@linux.vnet.ibm.com> <20200706181953.3592084-2-stefanb@linux.vnet.ibm.com>
User-agent: mu4e 1.4.10; emacs 26.3
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jarkko.sakkinen@linux.intel.com, linux-acpi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v9 1/2] acpi: Extend TPM2 ACPI table with missing log fields
In-reply-to: <20200706181953.3592084-2-stefanb@linux.vnet.ibm.com>
Date:   Mon, 06 Jul 2020 15:02:14 -0700
Message-ID: <87h7ukwbdl.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Stefan Berger @ 2020-07-06 11:19 MST:

> From: Stefan Berger <stefanb@linux.ibm.com>
>
> Recent extensions of the TPM2 ACPI table added 3 more fields
> including 12 bytes of start method specific parameters and Log Area
> Minimum Length (u32) and Log Area Start Address (u64). So, we define
> a new structure acpi_tpm2_phy that holds these optional new fields.
> The new fields allow non-UEFI systems to access the TPM2's log.
>
> The specification that has the new fields is the following:
>   TCG ACPI Specification
>   Family "1.2" and "2.0"
>   Version 1.2, Revision 8
>
> https://trustedcomputinggroup.org/wp-content/uploads/TCG_ACPIGeneralSpecification_v1.20_r8.pdf
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Cc: linux-acpi@vger.kernel.org
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
>  include/acpi/actbl3.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
> index b0b163b9efc6..bdcac69fa6bd 100644
> --- a/include/acpi/actbl3.h
> +++ b/include/acpi/actbl3.h
> @@ -415,6 +415,13 @@ struct acpi_table_tpm2 {
>  	/* Platform-specific data follows */
>  };
>  
> +/* Optional trailer for revision 4 holding platform-specific data */
> +struct acpi_tpm2_phy {
> +	u8  start_method_specific[12];
> +	u32 log_area_minimum_length;
> +	u64 log_area_start_address;
> +};
> +
>  /* Values for start_method above */
>  
>  #define ACPI_TPM2_NOT_ALLOWED                       0

