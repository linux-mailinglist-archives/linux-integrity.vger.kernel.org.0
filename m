Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C98B01350E
	for <lists+linux-integrity@lfdr.de>; Fri,  3 May 2019 23:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbfECV7N (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 May 2019 17:59:13 -0400
Received: from linux.microsoft.com ([13.77.154.182]:43854 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbfECV7M (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 May 2019 17:59:12 -0400
Received: from [10.200.157.26] (unknown [131.107.160.154])
        by linux.microsoft.com (Postfix) with ESMTPSA id 484F830549E2
        for <linux-integrity@vger.kernel.org>; Fri,  3 May 2019 14:59:12 -0700 (PDT)
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Subject: setfattr to set security.ima fails with error "Invalid argument"
To:     Linux Integrity <linux-integrity@vger.kernel.org>
Message-ID: <b1107806-26b5-4518-724f-9aab0b86668b@linux.microsoft.com>
Date:   Fri, 3 May 2019 14:59:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

I am running Ubuntu 4.18.0-17 (x86_64)
"ext4" is the mounted file system for the drive.

When trying to set security.ima extended attribute on any file I get 
error "Invalid argument".

setfattr -n security.ima -v foo /boot/vmlinuz-4.18.0-17-generic
setfattr: /boot/vmlinuz-4.18.0-17-generic: Invalid argument

If I try any other name for the extended, say, foo I see error 
"Operation not supported".

setfattr -n foo -v bar /boot/vmlinuz-4.18.0-17-generic
setfattr: /boot/vmlinuz-4.18.0-17-generic: Operation not supported

Note that if use "user." prefix in the extended attribute's name it 
works fine. For example,

setfattr -n user.foo -v user.bar /boot/vmlinuz-4.18.0-17-generic

getfattr -d /boot/vmlinuz-4.18.0-17-generic
getfattr: Removing leading '/' from absolute path names
# file: boot/vmlinuz-4.18.0-17-generic
user.foo="user.bar"

I have tried setting "user_xattr" option in /etc/fstab.

Do I have enable any other option\config to allow setting\updating 
security.ima attribute?

thanks,
  -lakshmi

