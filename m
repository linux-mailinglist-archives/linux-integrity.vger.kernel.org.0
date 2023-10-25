Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23897D662F
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Oct 2023 11:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbjJYJEE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 25 Oct 2023 05:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234582AbjJYJD5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Oct 2023 05:03:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DE6134
        for <linux-integrity@vger.kernel.org>; Wed, 25 Oct 2023 02:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698224594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
        b=cYKAxuJsn85XMLt/OXdURfkgIBZnISS9qMGKcGyoLAxAeJTB+Ou9ENvG2nTze+aEyrEdM7
        Sm+AwVTaZebnvf5uHij9HHHPFFuQqNBXWG4RMCql0RhSeeroyE8rGVCpX6gAaX5+HwyoE9
        dd50UEHNHHDYp5i3//rgNl/zYdEOGAk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-UTxitW6kNzur_zRvZSagQg-1; Wed, 25 Oct 2023 05:03:12 -0400
X-MC-Unique: UTxitW6kNzur_zRvZSagQg-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-41cc9224395so63653511cf.1
        for <linux-integrity@vger.kernel.org>; Wed, 25 Oct 2023 02:03:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698224591; x=1698829391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
        b=Fqs6qbBTVhXGs68cYk/QSjW/I9fD+0J5ccFHBiYJ6u1EQqwiVpoUDphGkTqGcddFwv
         zwh1S+tW4vkH4T5f1lyS+4bE6MV7RU3DcLynPXZQNbnWm9DNOJCOl4Hye0f4IPV4t/QW
         PPoWgwz4DF7arnZk5C9KZGoYkC7+77bom4xkbH8LdC5LFhTc28wvRoDS5mxU3uwNw7Gs
         DG4r6s/cKmQeReFhbH2O91N57Q+3iExFY3lJGeal39n+GGHSrJCpGFyNBOKJqZdbr1k5
         7LUvlCanXMbt1VUFcl530xuVv83j/P8P6CGsRXBOM92ZEhTposR5ONMe6ZkWbfpkqkEz
         I9sA==
X-Gm-Message-State: AOJu0YxymDFhKtVsI385Sl9k5Stj/cu9P95dtKoYQxREBV2QSv6nBAC8
        PTDLwMAvx5nsZc31YYZ6SeT1pZsKkSi6szbbCZoYau/m8VsoZW+KNRdzH6II1Mgtf9ypVBmu1eH
        VFaqgvyfQKthuosyZgiB01TlYVzebqEOHgOhm
X-Received: by 2002:a05:622a:1305:b0:419:544d:1c0 with SMTP id v5-20020a05622a130500b00419544d01c0mr17955950qtk.3.1698224591678;
        Wed, 25 Oct 2023 02:03:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKOfz8sf6QMk36USoRncwKMxVog3YxhlFfRKHvCE/VcGDwXrOh6CeVi2R2TKYVAgVn3giadQ==
X-Received: by 2002:a05:622a:1305:b0:419:544d:1c0 with SMTP id v5-20020a05622a130500b00419544d01c0mr17955935qtk.3.1698224591485;
        Wed, 25 Oct 2023 02:03:11 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id h21-20020ac87455000000b00419b094537esm4083814qtr.59.2023.10.25.02.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 02:03:11 -0700 (PDT)
Date:   Wed, 25 Oct 2023 02:03:09 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        William Roberts <bill.c.roberts@gmail.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Julien Gomes <julien@arista.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/6] tpm: Move buffer handling from static inlines to
 real functions
Message-ID: <qktrbbbqrz3z4jh4h7pz42leikmyg2mdevzl2brapn32kst55e@s5thpstdtlxp>
References: <20231024011531.442587-1-jarkko@kernel.org>
 <20231024011531.442587-2-jarkko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024011531.442587-2-jarkko@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

