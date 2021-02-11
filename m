Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4072F318D01
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Feb 2021 15:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbhBKOIe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 11 Feb 2021 09:08:34 -0500
Received: from mxout01.lancloud.ru ([45.84.86.81]:36456 "EHLO
        mxout01.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbhBKOGB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Feb 2021 09:06:01 -0500
X-Greylist: delayed 585 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Feb 2021 09:06:00 EST
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru 0890520E9243
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Dmitriy Gerasimov <d.gerasimov@omprussia.ru>
To:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: Should SKID be used as keyid in IMA signature?
Thread-Topic: Should SKID be used as keyid in IMA signature?
Thread-Index: AQHXAH2DEmXfN3il6EykK/wUecAuvg==
Date:   Thu, 11 Feb 2021 13:55:11 +0000
Message-ID: <244E7BE8-8328-4052-8F50-F23595A324FF@omprussia.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.11.136]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7776D3C2F32700469AD39C39FE763CF9@lancloud.ru>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

While kernel always trusts to X.509 SKID extension and using last 4 bytes
of it as keyid, ima-evm-utils is using SHA-1 to generate keyid from
a public key.

This becomes a problem if something different from SHA-1 was used to
generate SKID (e.g SHA-256). In this case, kernel will not be able to
verify produced IMA signature as there will be no available key with
such keyid.

So, do we need to provide means for using SKID from certificate as keyid
in ima-evm-utils?

Or is it the kernel who should always generate SHA-1-based keyid?
