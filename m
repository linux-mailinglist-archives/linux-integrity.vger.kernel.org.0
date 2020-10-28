Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B74A29D91B
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Oct 2020 23:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389301AbgJ1WoZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Oct 2020 18:44:25 -0400
Received: from mx0b-00176a03.pphosted.com ([67.231.157.48]:64496 "EHLO
        mx0a-00176a03.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389277AbgJ1Wmq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Oct 2020 18:42:46 -0400
X-Greylist: delayed 3237 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Oct 2020 18:42:46 EDT
Received: from pps.filterd (m0048299.ppops.net [127.0.0.1])
        by m0048299.ppops.net-00176a03. (8.16.0.42/8.16.0.42) with SMTP id 09SJH7HE007403
        for <linux-integrity@vger.kernel.org>; Wed, 28 Oct 2020 15:32:03 -0400
From:   "Ahmed, Safayet (GE Research, US)" <Safayet.Ahmed@ge.com>
To:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: evmctl argument parsing, HMAC algorithm, HMAC replacement
Thread-Topic: evmctl argument parsing, HMAC algorithm, HMAC replacement
Thread-Index: AdatSwxlcXMoK+W2SsCwyvuGMpS9oAAFIN1A
Date:   Wed, 28 Oct 2020 19:31:59 +0000
Message-ID: <4256e1cc5c5340eba005039e13fcbd5a@ge.com>
References: <85ea42e260344f5bb7e21daec5f2d3d0@ge.com>
In-Reply-To: <85ea42e260344f5bb7e21daec5f2d3d0@ge.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcMjAwMDE5OTI1?=
 =?us-ascii?Q?XGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0?=
 =?us-ascii?Q?YmEyOWUzNWJcbXNnc1xtc2ctMzAzM2Y2ZTktMTk1NC0xMWViLTkyY2QtNWM1?=
 =?us-ascii?Q?ZjY3YjU2ZWFkXGFtZS10ZXN0XDMwMzNmNmViLTE5NTQtMTFlYi05MmNkLTVj?=
 =?us-ascii?Q?NWY2N2I1NmVhZGJvZHkudHh0IiBzej0iMTc1MSIgdD0iMTMyNDgzODcwOTUx?=
 =?us-ascii?Q?ODYxMzg3IiBoPSJ5YkN1dkdGcnVvY29UTE0rK2dqOW9welhYRG89IiBpZD0i?=
 =?us-ascii?Q?IiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFDUUVB?=
 =?us-ascii?Q?QUNMN0kzeVlLM1dBU0VVVWUvK1RTNzBJUlJSNy81Tkx2UUdBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBSEFBQUFDMEF3QUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBUUFCQUFBQVBzcXFNd0FBQUFBQUFBQUFBQUFBQUo0QUFBQm5BR1VB?=
 =?us-ascii?Q?WHdCakFHOEFiZ0JtQUdrQVpBQmxBRzRBZEFCcEFHRUFiQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdjQVpRQmZBR2dBYVFCbkFHZ0Fi?=
 =?us-ascii?Q?QUI1QUdNQWJ3QnVBR1lBYVFCa0FHVUFiZ0IwQUdrQVlRQnNBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNB?=
 =?us-ascii?Q?QUFBQUFDZUFBQUFad0JsQUY4QWJnQnZBRzRBY0FCMUFHSUFiQUJwQUdNQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCbkFH?=
 =?us-ascii?Q?VUFYd0J3QUc4QWR3QmZBR01BYndCdUFHWUFhUUJrQUdVQWJnQjBBR2tBWVFC?=
 =?us-ascii?Q?c0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR2NBWlFCZkFIQUFid0IzQUY4?=
 =?us-ascii?Q?QWFBQnBBR2NBYUFCc0FIa0FYd0JqQUc4QWJnQm1BR2tBWkFCbEFHNEFkQUJw?=
 =?us-ascii?Q?QUdFQWJBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFB?=
 =?us-ascii?Q?Q0FBQUFBQUNlQUFBQWNBQnZBSGNBWlFCeUFGOEFaQUJsQUhNQWFRQm5BRzRB?=
 =?us-ascii?Q?WHdCd0FISUFZUUJqQUhRQWFRQmpBR1VBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48?=
 =?us-ascii?Q?L21ldGE+?=
x-dg-rorf: true
x-originating-ip: [3.202.188.220]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-10-28_09:2020-10-28,2020-10-28 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 malwarescore=0 clxscore=1011 impostorscore=0 mlxscore=0 spamscore=0
 mlxlogscore=987 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010280122
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello,

I just had a few questions:

1) evmctl utility source, "evmctl.c", in "sign_ima_file" function on line 713:
the default signing-key path is set to "/etc/keys/privkey_evm.pem".
Should that be "/etc/keys/privkey_ima.pem"?

2) Currently, the hashing algorithm for HMAC signatures in the kernel is hardcoded to SHA1.
SHA1 is considered too short to provide protection against collision attacks. (Such attacks have been demonstrated).
Are there plans to move to more secure hashing algorithms?

3) Is there any document that lists the events that cause the kernel to update asymmetric EVM signatures with HMAC signatures?

I thnk this update happens in "evm_update_evmxattr".
This function is called directly by "evm_verify_hmac", but I didn't fully understand the set of conditions that need to be satisfied before the replacement is performed.

There is a call chain from IMA's "process_measurement" function to "evm_verify_hmac".

I did some experiments where I
- check the "security.evm" extended attribute using the "getfattr" utility on a script with an IMA and EVM RSA signature.
- perform an operation
- check the extended attribute again to see if it's replaced with something much shorter.

In my experiment, just calling the script (which should eventually invoke ""process_measurement") doesn't cause the EVM RSA signature to be replaced with an HMAC signature.

However, I've been able to force the replacement by changing file attributes. I suspect changes to extended attributes will achieve the same as well.

Thank you for your help,

Safayet N. Ahmed Ph.D
Lead Engineer
Embedded Computing Group
GE Research

