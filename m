Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91CC71AE9B
	for <lists+linux-integrity@lfdr.de>; Mon, 13 May 2019 02:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfEMAhy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 12 May 2019 20:37:54 -0400
Received: from linux.microsoft.com ([13.77.154.182]:55474 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbfEMAhy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 12 May 2019 20:37:54 -0400
Received: by linux.microsoft.com (Postfix, from userid 1020)
        id EDA5F2074A36; Sun, 12 May 2019 17:37:53 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by linux.microsoft.com (Postfix) with ESMTP id E7ED9316F147;
        Sun, 12 May 2019 17:37:53 -0700 (PDT)
Date:   Sun, 12 May 2019 17:37:53 -0700 (PDT)
From:   nramas@linux.microsoft.com
X-X-Sender: nramas@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net
To:     linux-integrity@vger.kernel.org
cc:     zohar@linux.ibm.com
Subject: IMA signature generated by evmctl has unexpected key identifier
Message-ID: <alpine.LRH.2.21.1905092048590.7180@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.inter>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello,

I am trying to test IMA signature validation using EVMCTL version 1.1
Am running kernel version 5.1.0 rc2 on an Ubuntu desktop.

I have followed the steps given in the README below:
https://sourceforge.net/p/linux-ima/ima-evm-utils/ci/master/tree/README

I have created private\public key pair and the DER encoded certificate for 
the private key. Imported the signed DER encoded cert to IMA keyring.

keyctl show %keyring:.ima
Keyring
1054868458 ---lswrv      0     0  keyring: .ima
  740136756 --als--v      0     0   \_ asymmetric: hostname: whoami signing
key: 85512d09fc12c7f38b9679352651dcb365903336

cat /proc/keys | grep -i signing
2c1d9734 I--Q---     1 perm 39010000     0     0 asymmetri hostname:
whoami signing key: 85512d09fc12c7f38b9679352651dcb365903336: X509.rsa
65903336 []

evmctl ima_sign -a sha256 --key /etc/keys/privkey_evm.pem /boot/vmlinuz-5.1.0-rc2+

In the key identifier set in security.ima attribute the key identifier 
should be 65903336 to match the key in the IMA keyring. But it is 
b8847de9.

getfattr -d -m ima -e hex /boot/vmlinuz-5.1.0-rc2+
getfattr: Removing leading '/' from absolute path names
# file: boot/vmlinuz-5.1.0-rc2+
security.ima=0x030204b8847de90080b06c8d5517a6afea64805c2871581b256a4efcf7ce4ba079a85545e5e70a2603596366c4e342f11052291e9b558ccb1a1208747f12c45bbe4cee59c727f308a46e951c0df9b1f6b443a8c0a4f5ac881d49e0cce9927b64eeab29c5688aba0758e5cfb30c26fd5b131c2206f1b208d48a427c53a77ae5baf98f4994a19f67b163

When trying to verify the IMA signature I get the following error

evmctl ima_verify --key /etc/keys/x509_evm.der /boot/vmlinuz-5.1.0-rc2+
/boot/vmlinuz-5.1.0-rc2+: RSA_public_decrypt() failed: -1
error:0407008A:rsa routines:RSA_padding_check_PKCS1_type_1:invalid 
padding
error:04067072:rsa routines:rsa_ossl_public_decrypt:padding check failed

This looks very similar to the issue discussed here
https://sourceforge.net/p/linux-ima/mailman/message/34290588/

But the bug discussed in the above thread looks to be fixed though.

Am I missing something?

Thank you.

  -lakshmi


