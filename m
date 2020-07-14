Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A120121EDE5
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jul 2020 12:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgGNKZC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Jul 2020 06:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgGNKZB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Jul 2020 06:25:01 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDCCC061755
        for <linux-integrity@vger.kernel.org>; Tue, 14 Jul 2020 03:25:01 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id w27so12308226qtb.7
        for <linux-integrity@vger.kernel.org>; Tue, 14 Jul 2020 03:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=vhgY5LPEpxTGfN8PeYcs05WGVIdTQTJjTdgL4qSsPAU=;
        b=TaRftIf7IgIv/e0NHlLo86EMmxVYSs8g7YyUCQV2y2wkCCpwtqwZfLHebjjNjwobc6
         Pp/ql7qSqbmZnTJdMetvm5gPqomRKBO034+xonbw3+vtAPrwLMHk3FwlfRICeC9704H0
         j0PXm/Z0ugvphaAjnSPUehD4V4dRzuMUX9QL4Lo5brZ6nN+vQlGx7CRxmlMBBQXcjhsn
         RLRg4g5koIYAxr72CZ6vY+zwxeqIBFasDd3JnUkwIyWAGMusz6M84bdF17ptckO9suYz
         6v8HRfD0tGS574TNKdFIj5GY59tGmvoTahSjCFTPysBdVmkvjn0cSyimHfXSjOaNVGnF
         7IaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=vhgY5LPEpxTGfN8PeYcs05WGVIdTQTJjTdgL4qSsPAU=;
        b=fI2biAyjFk6SGNDvtTw8YI8QIbaxN2uYl+mpthAqKmsQIQ+L1OT9f+3h26WAOZ+Y8V
         Hsge1VjdnAzFCn4o8j/j3DyMUSvBBs8CmfvrxMzv7MpCFJPbz93L7seecDBwnTGWrGBY
         NF7fqaljcLD5tu10zp+NsrkPlMsjqY3WcZezAfX41qnbkMUvwjK2Dbf8TNZacCBMCHiG
         FKo6EeUaU0HsfeEmk1BFNx0YBTQqg5csbz9KNUV7Um+8uBXJVhKg3Wuh4AhHXOKHpr7D
         YGw29Feb7l8/kwEqRioyrym0hhTOD9TdynlThTGg6DcEKyZk4S02xSCYrmNZZQdBIDA8
         mJVw==
X-Gm-Message-State: AOAM531qTesFGRq8woymzKf5MgWfNl0YtwXdj+aab+6Yj024KUTKc8LS
        YMevKyY7X0pNOE9vPJOV1gzMJeUJFOJbX2XWeB+d6w==
X-Google-Smtp-Source: ABdhPJwe6Q+VBkVWVxRVgE/FfFt0lFOqn2a60/IcRS6ARp8dQoT5xpQNxfVGW+/LG1u9da5rASPnTt27NIaL2MXiFEk=
X-Received: by 2002:ac8:1b8b:: with SMTP id z11mr3896180qtj.6.1594722299602;
 Tue, 14 Jul 2020 03:24:59 -0700 (PDT)
MIME-Version: 1.0
From:   rishi gupta <gupt21@gmail.com>
Date:   Tue, 14 Jul 2020 15:54:48 +0530
Message-ID: <CALUj-gu9-0ZKDvTAOFN1jcbYBUXMymPTJmyD=J6C58mVoKi4pQ@mail.gmail.com>
Subject: Queries regarding portable feature and signing process for EVM
To:     linux-integrity <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Matthew,Mimi,

Few queries in context of 4.14 kernel:
- Does it support portable EVM feature.
- For EVM traditionally we need to sign files on the device itself.
Can we now use portable EVM as a method to sign files during build
itself.

Regards,
Rishi
