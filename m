Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A06424F61
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Oct 2021 10:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbhJGIkk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Oct 2021 04:40:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47505 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232348AbhJGIkk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Oct 2021 04:40:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633595926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gV3DZeXCPyHSzMb6uq/ynaElhsTu6mj4dUlnSUGmOx8=;
        b=PtRuAWWWzs829VXMeX/+G1jugig3WdsYZl8j9/zkWee+QZJvqkfMvGzEdVMSGdasqoBN/6
        5j7f1Y9zv4OZ6K1B+2rhF8EApTnO837p+2kC5v6zS3wWAOp1hu0POpKO5Her9RJAyvzU82
        QfRB5Z4HB6ecQVZQno3bSQcnS1uCW28=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-e766je8wMXKMv8Fc2KhP_A-1; Thu, 07 Oct 2021 04:38:35 -0400
X-MC-Unique: e766je8wMXKMv8Fc2KhP_A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A33184A5E7;
        Thu,  7 Oct 2021 08:38:34 +0000 (UTC)
Received: from fedora (unknown [10.39.195.104])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4AE801F464;
        Thu,  7 Oct 2021 08:38:33 +0000 (UTC)
Message-ID: <87fstdb56l.fsf-dueno@redhat.com>
From:   Daiki Ueno <dueno@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org
Subject: Re: [PATCH] IMA: make runtime measurement list pollable
References: <20211005144414.64547-1-dueno@redhat.com>
        <6ade3979fd113902aadf48eb97a15f86e19bf86f.camel@linux.ibm.com>
Date:   Thu, 07 Oct 2021 10:38:26 +0200
In-Reply-To: <6ade3979fd113902aadf48eb97a15f86e19bf86f.camel@linux.ibm.com>
        (Mimi Zohar's message of "Wed, 06 Oct 2021 19:18:38 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello Mimi,

Mimi Zohar <zohar@linux.ibm.com> writes:

> Hi Daiki,
>
> On Tue, 2021-10-05 at 16:44 +0200, Daiki Ueno wrote:
>> The IMA runtime measurement list exposed on securityfs is currently
>> not pollable, so applications that incrementally verify the
>> measurements have to monitor the file periodically.  This patch makes
>> it possible to poll the file in a similar fashion to the sysfs files,
>> i.e., POLLPRI will be signalled on any changes to the list.
>> 
>> Signed-off-by: Daiki Ueno <dueno@redhat.com>
>
> With the sample code in the poll man page and without this patch, the
> ascii measurement list is pollable.  I must be missing something.

The sample code polls with POLLIN, so every poll() call returns
immediately, even if there is no change in the measurement list.  That
is not ideal in some scenarios[1], and could be a CPU hog as the calling
process never sleeps.

With this patch, poll() behaves the same for POLLIN, while the user
program is also able to wait for actual changes to the measurement list,
with POLLPRI.

> The call to wake_up_interruptible() probably should not be here, but in
> the caller after the TPM is extended.   With that change, you would be
> able to differentiate between restoring the measurement list after
> kexec and regular additional measurements.

Thank you for the suggestion; I will test that change and get it back to
you soon.

Regards,

Footnotes:
[1]  https://github.com/keylime/keylime/blob/master/keylime/cmd/ima_emulator_adapter.py#L95
     Currently the poll() in the loop is no-op and it would spin if
     there is no time.sleep()

-- 
Daiki Ueno

