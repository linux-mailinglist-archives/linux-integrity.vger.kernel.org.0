Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D11E12FCDD
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Jan 2020 20:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbgACTJn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 Jan 2020 14:09:43 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33602 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728380AbgACTJn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Jan 2020 14:09:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578078582;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=Mi+p+XgkDLMfGQNM+tJDQI6d+aqqQMXlBNSJj/pQl2Y=;
        b=WJsyKTh3LKMcNN1WlengF5L4garbeFOUi2lS0FFguX8CMeqlGH8hwavi7lsMsV1hpbr3t2
        qgctCl7cEnDhMR9RBWBSk/j67qJXTVpN8Ir6oA72ocjawDzP0YZqjpZ/5J9kBwgtmBXob2
        oN2mnmh8phEujQZCfQr4/ZAwtftoyZ0=
Received: from mail-yw1-f70.google.com (mail-yw1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-ftJ3KJEqMbKCxHEKnBx1gg-1; Fri, 03 Jan 2020 14:09:39 -0500
X-MC-Unique: ftJ3KJEqMbKCxHEKnBx1gg-1
Received: by mail-yw1-f70.google.com with SMTP id w4so34861557ywa.16
        for <linux-integrity@vger.kernel.org>; Fri, 03 Jan 2020 11:09:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=Mi+p+XgkDLMfGQNM+tJDQI6d+aqqQMXlBNSJj/pQl2Y=;
        b=VsGTRw18Zv152D1EiFcpcdYU+lQErU0EwbQcykEbWZlA6rCRmSN/gZHxSAMiKb6TRy
         2lOkp815piG7kGGGBmmc2y1FOsbeC8DsZUg7OgEAFcPAVY18DbOICKAfLDhvT6R7tf2o
         bgSUIgjqBg4v6vVe7CLIRdyx5idVuPs3NjPOOB1TfPY/PZOsM9VeFImlBJUbf0ckyRZ+
         wqnWv5SSK6eGg4klwBei6c7gLOjdlIQXYgBfglou0KtbIsSdAM5ZXNxBBvNo2VbKALBM
         c85o3zoXEbWPOeD5CvAbmWdrboq6Dd8ohyEVlS5zkzdkPrL7qEdcZu5M0qNcSMKFnEIb
         LB2Q==
X-Gm-Message-State: APjAAAVcZ+6tmYH2MXcv0J0LK9x3a46khcLT82wP2hJ/4qYdMwxwnF+F
        CFI/DmDH85q28Q/fc81TdVgt0pnQzOWBtRE2yRgKeF2x7pwNcix2Ss3jOaFb/WZAGzENlsWk5e3
        b2YT9e4uvR+qsqss7cenmR7Ua2BE1
X-Received: by 2002:a25:508:: with SMTP id 8mr54774794ybf.18.1578078578493;
        Fri, 03 Jan 2020 11:09:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqzcgl0UlQ1U9iM6U8Ycl3qLNG3u1tlA+J3sW0sRGH+D5J4oCWZdJYeIQK8iYwS+cMT5CuQOTA==
X-Received: by 2002:a25:508:: with SMTP id 8mr54774780ybf.18.1578078578212;
        Fri, 03 Jan 2020 11:09:38 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id p1sm25467653ywh.74.2020.01.03.11.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 11:09:37 -0800 (PST)
Date:   Fri, 3 Jan 2020 12:09:35 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     linux-integrity@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Matthew Garrett <mjg59@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH V2] tpm: Don't make log failures fatal
Message-ID: <20200103190935.yol52xqjg7f6js7k@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <20200102215518.148051-1-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200102215518.148051-1-matthewgarrett@google.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu Jan 02 20, Matthew Garrett wrote:
>If a TPM is in disabled state, it's reasonable for it to have an empty
>log. Bailing out of probe in this case means that the PPI interface
>isn't available, so there's no way to then enable the TPM from the OS.
>In general it seems reasonable to ignore log errors - they shouldn't
>interfere with any other TPM functionality.
>
>Signed-off-by: Matthew Garrett <mjg59@google.com>
>Cc: stable@vger.kernel.org
>---

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

