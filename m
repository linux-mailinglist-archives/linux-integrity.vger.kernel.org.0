Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29CE9139DC5
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jan 2020 01:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbgANAGR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Jan 2020 19:06:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52015 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729219AbgANAGR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Jan 2020 19:06:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578960376;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type; bh=yLcVQb3cwfXTm6TPhyux9bYnq0XPv4S65C7D0UXCAZY=;
        b=LR9lHoQKVVrYPYvfJwfHOgHSYE2pXUWwysZfyFa6DVgUPu8drJE/+d4dvlL8IXdsAg6We6
        RYqWcWegRclGK/HWFxmrEfXfaKN3z96F66Hjfr++stBrXj8Q/2Ccin+Mwn3s1IZ7m3UenZ
        gF86plQKkkOYsd7I+5Pp8zxXePjm3bs=
Received: from mail-yw1-f69.google.com (mail-yw1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-XxEuvzlKNny4KmyFWkzMzQ-1; Mon, 13 Jan 2020 19:06:06 -0500
X-MC-Unique: XxEuvzlKNny4KmyFWkzMzQ-1
Received: by mail-yw1-f69.google.com with SMTP id c68so14074403ywa.2
        for <linux-integrity@vger.kernel.org>; Mon, 13 Jan 2020 16:06:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:reply-to
         :mime-version:content-disposition;
        bh=yLcVQb3cwfXTm6TPhyux9bYnq0XPv4S65C7D0UXCAZY=;
        b=W0BMyyDhAhRXdN2NZsn8d7DCBgDtb5+WhX1pIuyGP6eVkIR/+GZK1Yk+PyjVlxgaFv
         U1jZU53IMnjc+osP2hTpFGkFGqWIdIAEHvFc1bfosNSlo62n5oKDKu3oGJhEVEd+g1hr
         sT3Y+4JiMsR5vAqrzbltaPM+ygX2PtPiGCDO4LmJfmDvS/9VYagKI8aOH5QMpFODWiQA
         +J5AyuyIDve94pMWtSBwJdBTNquCCumVsBbGqO6qPcFMeUsZNCRNTb1wPS/VuN284Ljg
         0+YOZnpEvKT8VuTyn9wTiSbjSLeeyyvYtiV7h01BWLw7sDXC/dLIs8Em/LBg/g9+xGRP
         ttFA==
X-Gm-Message-State: APjAAAW113nbdJJ8GsUcDTpESpO4b9jx6mB63XikwMnMC24UjB1AL7Yy
        py2ZPk2YvdyWPARMuOYSeqq1lhO97qcjOgMr1NSCJE+nNiLpbkPPwnCGOUSk7tQYvyYVFhifvI4
        bzvF1NoXZSBDHux6Xj9ds7Fzx52fz
X-Received: by 2002:a81:98c7:: with SMTP id p190mr14921386ywg.385.1578960365299;
        Mon, 13 Jan 2020 16:06:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqyn6FMTlkDBS5KGVjzKKTTci1VJHTE3m+6xGlmFzo5dyYY9N0CQJaQZX1mlEufy2C3RxDuN/A==
X-Received: by 2002:a81:98c7:: with SMTP id p190mr14921370ywg.385.1578960365054;
        Mon, 13 Jan 2020 16:06:05 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id z2sm5731329ywb.13.2020.01.13.16.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 16:06:04 -0800 (PST)
Date:   Mon, 13 Jan 2020 17:06:02 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Subject: ima pcr question
Message-ID: <20200114000602.h5k5rr2k6zl3dlts@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

We had a report of messages from ima saying "Error communicating with
TPM".  Looking into it a bit, it looks like with some Dell systems
(possibly others as well) in the bios they can set the hash algorithm
being used. In this case with that set to sha256 the messages
appear. Flipping the system to using sha1 makes them disappear.
Looking at the ima code, ima_calc_boot_aggregate_tfm hard codes using
sha1. Should that be changed to use whatever the default is in the
config, or possibly find out from the tpm what algorithm is being used?

Regards,
Jerry

